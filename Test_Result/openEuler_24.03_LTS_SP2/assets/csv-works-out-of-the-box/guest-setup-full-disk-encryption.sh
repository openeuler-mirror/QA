#!/bin/bash

# guest-setup-full-disk-encryption.sh

# Reject Ctrl+C
trap '' SIGINT

DEBUG=${DEBUG:-0}

if [ ${DEBUG} -eq 1 ]; then
  set -x
fi

source /etc/os-release

OS_NAME=""
OS_VERSION=""

readonly disk_uuid_format="[a-fA-F0-9]\{8\}-[a-fA-F0-9]\{4\}-[a-fA-F0-9]\{4\}-[a-fA-F0-9]\{4\}-[a-fA-F0-9]\{12\}"
readonly enc_fstype="crypto_LUKS"
readonly boot_blk_dev_backup="/tmp/boot-blk-dev-backup.tar"
readonly boot_blk_dev_mount_point="/boot"
readonly efi_mount_point="/boot/efi"
readonly fstab_conf="/etc/fstab"
readonly crypttab_conf="/etc/crypttab"
readonly user_grub_tarball="grub.tar.gz"
readonly luks_keyfile_top_dir="/etc/keys"
readonly luks_keyfile_slot=1

is_boot_blk_dev_encrypted=0
boot_blk_dev=""
boot_blk_dev_enc_passwd=""
boot_blk_dev_enc_part_name=""
boot_blk_dev_fstype=""

mkfs_bin=""
grub_install_bin=""
grub_update_bin=""
efi_os_dir=""
grub_conf_output_dir=""

nr_encrypted_blk_devs=0
# This is a array and looks like this:
#   ['/dev/sda2']='luks-12345678-1234-1234-1234-123456789abc'
# The 'key' of the array is the blk dev, the 'value' correspond to the 'key' is
# the encrypted partition number.
declare -A encrypted_blk_devs_info
# This is a array and looks like this:
#   ['/dev/sda2']='sda2password'
# The 'key' of the array is the blk dev, the 'value' correspond to the 'key' is
# the encryption key of the blk dev.
declare -A blk_devs_enc_passwd

err ()  { echo -e "\033[31m[Error]\033[0m$@"; }
warn () { echo -e "\033[33m[Warn]\033[0m$@"; }
info () { echo -e "\033[37m[Info]\033[0m$@"; }

is_ok () {
  local is_ok=${1:-0}
  [ ${is_ok} -eq 1 ] && echo -ne "\033[32;1m[Ok]\033[0m"
  [ ${is_ok} -eq 0 ] && echo -ne "\033[31m[x]\033[0m"
}

if [ $(id -u) -ne 0 ]; then
  err "need run as root" $(is_ok 0) ; exit 1
fi

check_bin () {
  local bin_name="$1"
  local action_str="Check '${bin_name}'"
  info "${action_str}"
  command which ${bin_name} > /dev/null || {
     err "${action_str}" $(is_ok 0) ; exit 1
  }
  info "${action_str}" $(is_ok 1)
}

check_env () {
  info "[Check env]"

  local grub_mod_check_cmd=""

  # Check OS version
  action_str="Check OS version"
  info "${action_str}"
  OS_NAME=${NAME}
  case "${OS_NAME}" in
  Anolis*)
    OS_VERSION=${VERSION_ID}
    case "${OS_VERSION}" in
    23*|8*)
      grub_install_bin="grub2-install"
      grub_update_bin="grub2-mkconfig"
      grub_mod_check_cmd="rpm -q grub2-efi-x64-modules"
      efi_os_dir="${efi_mount_point}/EFI/anolis"
      grub_conf_output_dir="/boot/grub2"
      ;;
    *)
      err "Unsupport OS version:${OS_NAME} ${OS_VERSION}" $(is_ok 0) ; exit 1
      ;;
    esac
    ;;
  openEuler*)
    OS_VERSION=${VERSION_ID}
    case "${OS_VERSION}" in
    24*)
      grub_install_bin="grub2-install"
      grub_update_bin="grub2-mkconfig"
      grub_mod_check_cmd="rpm -q grub2-efi-x64-modules"
      efi_os_dir="${efi_mount_point}/EFI/openEuler"
      grub_conf_output_dir="/boot/grub2"
      ;;
    *)
      err "Unsupport OS version:${OS_NAME} ${OS_VERSION}" $(is_ok 0) ; exit 1
      ;;
    esac
    ;;
  OpenCloudOS*)
    OS_VERSION=${VERSION_ID}
    case "${OS_VERSION}" in
    9*)
      grub_install_bin="grub2-install"
      grub_update_bin="grub2-mkconfig"
      grub_mod_check_cmd="rpm -q grub2-efi-x64-modules"
      efi_os_dir="${efi_mount_point}/EFI/opencloudos"
      grub_conf_output_dir="/boot/grub2"
      ;;
    *)
      err "Unsupport OS version:${OS_NAME} ${OS_VERSION}" $(is_ok 0) ; exit 1
      ;;
    esac
    ;;
  Ubuntu*)
    OS_VERSION=${VERSION_ID}
    case "${OS_VERSION}" in
    *)
      err "Unsupport OS version:${OS_NAME} ${OS_VERSION}" $(is_ok 0) ; exit 1
      ;;
    esac
    ;;
  *)
    err "Unknown OS:${OS_NAME}" $(is_ok 0) ; exit 1
    ;;
  esac
  info "${action_str}" $(is_ok 1) "${OS_NAME} ${OS_VERSION}"

  check_bin "${grub_install_bin}"
  check_bin "${grub_update_bin}"
  ${grub_mod_check_cmd} || {
    [ ! -e ${user_grub_tarball} ] && {
      err "Need install grub-efi, or provide ${user_grub_tarball}" $(is_ok 0)
      exit 1
    }
  }
  check_bin "lsblk"
  check_bin "cryptsetup"
  check_bin "blkid"
  check_bin "tar"

  # Collect all the LUKS encrypted block devices

  # Assume the output of lsblk is like this:
  # sdc
  # ├─sdc1          vfat              B72A-CD59
  # ├─sdc2          xfs               213afcf4-406a-41f3-8e6f-743a9f108e86
  # └─sdc3          crypto_LUKS       5rqPHx-rEYE-Y0C4-5Fot-wfkI-tVrw-3hFF71
  #   └─crypt_sda2  ext4              98765432-1234-5678-9abc-def012345678   /data
  local fstype_field_nr=$(lsblk -f | head -n1 |
	    awk -v field='FSTYPE' '{for (i = 1; i <= NF; i++)
            if ($i == field) print i}')
  local need_fetch_md=0
  local enc_blk_dev="" enc_part_name=""

  action_str="Collect LUKS encrypted block devices"
  info "${action_str}"
  while IFS= read -r line; do
    if [ "X$(echo "${line}" | awk -v target=${fstype_field_nr} '{print $target}')" \
         = "X${enc_fstype}" ]; then
      need_fetch_md=1
      continue
    fi
    if [ ${need_fetch_md} -eq 1 ]; then
      enc_part_name=$(echo "${line}" |
          sed 's/^[^a-zA-Z0-9]*\([a-zA-Z0-9][^ ]*\) .*/\1/')
      enc_blk_dev=$(cryptsetup status ${enc_part_name} | grep 'device:' |
          awk -F':' '{print $2}' | sed 's/ //g')
      encrypted_blk_devs_info["${enc_blk_dev}"]="${enc_part_name}"
      need_fetch_md=0
      let nr_encrypted_blk_devs++
      continue
    fi
  done < <(lsblk -f)
  info "Found ${nr_encrypted_blk_devs} encrypted block devices"
  for enc_blk_dev in "${!encrypted_blk_devs_info[@]}"; do
    info "${enc_blk_dev} 's luks UUID is: ${encrypted_blk_devs_info[${enc_blk_dev}]}"
  done

  if [ $(lsblk -o MOUNTPOINT | grep "${boot_blk_dev_mount_point}" | \
       grep -v "${efi_mount_point}" | wc -l) -ne 1 ]; then
    err "Cannot find ${boot_blk_dev_mount_point}" $(is_ok 0) ; exit 1
  fi
  string=$(lsblk -f | grep "${boot_blk_dev_mount_point}" |
           grep -v "${efi_mount_point}")
  if $(echo "${string}" | grep -q "^.* ${disk_uuid_format} .*$"); then
    if [ $(echo "${string}" | grep -Eic "crypt|luks") -eq 1 ]; then
      boot_blk_dev_enc_part_name=$(echo "${string}" |
          sed 's/^[^a-zA-Z0-9]*\([a-zA-Z0-9][^ ]*\) .*/\1/')
      boot_blk_dev=$(cryptsetup status ${boot_blk_dev_enc_part_name} |
          grep 'device:' | awk -F':' '{print $2}' | sed 's/ //g')
      is_boot_blk_dev_encrypted=1
      info "${boot_blk_dev} 's luks UUID is: ${boot_blk_dev_enc_part_name}"
    else
      boot_blk_dev=$(realpath /dev/disk/by-uuid/$(echo "${string}" |
          sed "s/.* \(${disk_uuid_format}\) .*/\1/"))
    fi
  else
    err "Invalid disk uuid format: ${disk_uuid_format}" $(is_ok 0) ; exit 1
  fi
  info "${action_str}" $(is_ok 1)

  # Check boot partition's fs
  boot_blk_dev_fstype=$(lsblk -o FSTYPE,MOUNTPOINT |
      grep "${boot_blk_dev_mount_point}" | grep -v "${efi_mount_point}" |
      awk '{print $1}')
  info "${boot_blk_dev_mount_point} info: ${boot_blk_dev} ${boot_blk_dev_fstype}"
  case "${boot_blk_dev_fstype}" in
  "xfs")
    mkfs_bin="mkfs.xfs"
    ;;
  "ext4")
    mkfs_bin="mkfs.ext4"
    ;;
  *)
    err "Unknow boot fs: ${boot_blk_dev_fstype}" $(is_ok 0) ; exit 1
    ;;
  esac
  check_bin "${mkfs_bin}"

  info "[Check env]" $(is_ok 1)
}

check_env

################################################################################
# Record passwords of boot partition and data partition
################################################################################
record_blk_devs_enc_passwd () {
  info "[Record encryption password of the block devices]"

  warn "\033[33m
    *** Now, you need input password of all the encrypted partitions, these
    passwords will be used in all the following steps related to encrypted
    partitions, you must keep the passwords in mind.\033[0m"

  local check_passwd=""
  local enc_blk_dev=""

  if [ ${is_boot_blk_dev_encrypted} -eq 0 ]; then
    info "Record boot partition's password"
    while [ -z "${boot_blk_dev_enc_passwd}" ]; do
      read -p "Press password of ${boot_blk_dev}:   " boot_blk_dev_enc_passwd
      read -p "Confirm password of ${boot_blk_dev}: " check_passwd

      [ "X${boot_blk_dev_enc_passwd}" = "X${check_passwd}" ] && break
      err "Password mismatch: ${boot_blk_dev_enc_passwd} != ${check_passwd}" $(is_ok 0)
      boot_blk_dev_enc_passwd=""
    done
    info "Set ${boot_blk_dev} 's passwd: ${boot_blk_dev_enc_passwd}" $(is_ok 1)
  fi

  info "Record all the encrypted partitions' password"
  for enc_blk_dev in ${!encrypted_blk_devs_info[@]}; do
    info "Current partition is: ${enc_blk_dev}"
    check_passwd=""
    while [ -z "$check_passwd" ]; do
      read -p "Press password of ${enc_blk_dev}: " check_passwd
      info "Test passphrase on ${enc_blk_dev}"

      cryptsetup luksOpen --test-passphrase --verbose ${enc_blk_dev} \
        <<< "${check_passwd}" && break
      err "Incorrect password of ${enc_blk_dev}: ${check_passwd}" $(is_ok 0)
      check_passwd=""
    done
    blk_devs_enc_passwd["${enc_blk_dev}"]="${check_passwd}"
    [ "X${enc_blk_dev}" = "X${boot_blk_dev}" ] && boot_blk_dev_enc_passwd="${check_passwd}"
    info "Check ${enc_blk_dev} 's passwd: ${check_passwd}" $(is_ok 1)
  done

  info "[Record encryption password of the block devices]" $(is_ok 1)
}

record_blk_devs_enc_passwd

################################################################################
# Setup disk encryption on boot partition
################################################################################
backup_boot_partition () {
  info "[Backup boot partition: ${boot_blk_dev}]"

  info "Show info of ${boot_blk_dev%%[0-9]*}"
  lsblk -o NAME,FSTYPE,UUID,MOUNTPOINT ${boot_blk_dev%%[0-9]*}

  action_str="Unmount ${efi_mount_point}"
  info "${action_str}"
  umount ${efi_mount_point} || {
    err "${action_str}" $(is_ok 0) ; exit 1
  }
  info "${action_str}" $(is_ok 1)

  action_str="Remount ${boot_blk_dev_mount_point} as readonly"
  info "${action_str}"
  mount -oremount,ro ${boot_blk_dev_mount_point} || {
    err "${action_str}" $(is_ok 0) ; exit 1
  }
  info "${action_str}" $(is_ok 1)

  action_str="Save ${boot_blk_dev_mount_point} to ${boot_blk_dev_backup}"
  info "${action_str}"
  install -m0600 /dev/null ${boot_blk_dev_backup}
  tar -C ${boot_blk_dev_mount_point} --acls --xattrs --one-file-system \
    -cf ${boot_blk_dev_backup} . || {
    err "${action_str}" $(is_ok 0) ; exit 1
  }
  info "${action_str}" $(is_ok 1)

  action_str="Unmount ${boot_blk_dev_mount_point}"
  info "${action_str}"
  umount ${boot_blk_dev_mount_point} || {
    err "${action_str}" $(is_ok 0) ; exit 1
  }
  info "${action_str}" $(is_ok 1)

  info "[Backup boot partition: ${boot_blk_dev}]" $(is_ok 1)
}

restore_boot_partition () {
  info "[Restore boot partition: ${boot_blk_dev}]"

  action_str="Mount ${boot_blk_dev_mount_point}"
  info "${action_str}"
  mount -v ${boot_blk_dev_mount_point} || {
    err "${action_str}" $(is_ok 0) ; exit 1
  }
  info "${action_str}" $(is_ok 1)

  action_str="Copy ${boot_blk_dev_backup} to ${boot_blk_dev_mount_point}"
  info "${action_str}"
  tar -C ${boot_blk_dev_mount_point} --acls --xattrs \
    -xf ${boot_blk_dev_backup} || {
    err "${action_str}" $(is_ok 0) ; exit 1
  }
  info "${action_str}" $(is_ok 1)

  action_str="Mount ${efi_mount_point}"
  info "${action_str}"
  mount -v ${efi_mount_point} || {
    err "${action_str}" $(is_ok 0) ; exit 1
  }
  info "${action_str}" $(is_ok 1)

  info "[Restore boot partition: ${boot_blk_dev}]" $(is_ok 1)
}

convert_boot_partition_to_luks1 () {
  info "[Convert boot parttion to LUKS1]"

  # Skip if boot partition has already been encrypted
  if [ ${is_boot_blk_dev_encrypted} -eq 1 ]; then
    info "${boot_blk_dev} has already encrypted, skip" $(is_ok 1)
    return
  fi

  backup_boot_partition

  action_str="Format ${boot_blk_dev} to LUKS1"
  info "${action_str}"
  cryptsetup luksFormat --type luks1 ${boot_blk_dev} <<EOF
${boot_blk_dev_enc_passwd}
${boot_blk_dev_enc_passwd}
EOF
  if [ $? -ne 0 ]; then
    err "${action_str}" $(is_ok 0) ; restore_boot_partition ; exit 1
  fi
  info "${action_str}" $(is_ok 1)

  local warn_str="\033[31;7m
   !!! The boot partition is formatted in LUKS1 with a specified password. But
       you encounter some errors when
         1) setting device mapper for the encrypted boot partition,
         or
         2) executing ${mkfs_bin} on the LUKS1 encrypted boot partition,
       so you should handle the above situation by executing the commands for
       1) or 2) again.\033[0m"

  local uuid_luks="$(blkid -o value -s UUID ${boot_blk_dev})"
  local uuid_in_fstab="$(grep -Ei "uuid.*${boot_blk_dev_mount_point}\s" \
      ${fstab_conf} | cut -d ' ' -f1 | cut -d '=' -f2 | awk '{print $1}')"
  local enc_part_name="" devname="" mkfs_cmd=""

  boot_blk_dev_enc_part_name="luks-${uuid_luks}"
  info "${boot_blk_dev} 's luks UUID is: ${boot_blk_dev_enc_part_name}"

  enc_part_name="${boot_blk_dev_enc_part_name}"
  devname="/dev/mapper/${enc_part_name}"

  action_str="Open ${boot_blk_dev} as ${enc_part_name}"
  info "${action_str}"
  echo "${enc_part_name} UUID=${uuid_luks} none luks" | tee -a ${crypttab_conf}
  cryptsetup luksOpen ${boot_blk_dev} ${enc_part_name} \
    <<< "${boot_blk_dev_enc_passwd}" || {
    err "${action_str}" $(is_ok 0) ; err "${warn_str}" ; exit 1
  }
  info "${action_str}" $(is_ok 1)

  info "${boot_blk_dev_mount_point} 's UUID in ${fstab_conf}: ${uuid_in_fstab}"
  action_str="Create ${boot_blk_dev_fstype} for ${enc_part_name} ${uuid_in_fstab}"
  info "${action_str}"
  case "${OS_NAME}" in
  Anolis*)
    case "${OS_VERSION}" in
    23*|8*)
      case "${mkfs_bin}" in
      "mkfs.xfs")
        mkfs_cmd="${mkfs_bin} -m uuid=${uuid_in_fstab} -d name=${devname} -f -q"
        ;;
      "mkfs.ext4")
        mkfs_cmd="${mkfs_bin} -m0 -U ${uuid_in_fstab} ${devname} -q"
        ;;
      *)
        err "${warn_str}" ; exit 1
        ;;
      esac
      ;;
    *)
      err "${warn_str}" ; exit 1
      ;;
    esac
    ;;
  openEuler*)
    case "${OS_VERSION}" in
    24*)
      case "${mkfs_bin}" in
      "mkfs.xfs")
        mkfs_cmd="${mkfs_bin} -m uuid=${uuid_in_fstab} -d name=${devname} -f -q"
        ;;
      "mkfs.ext4")
        mkfs_cmd="${mkfs_bin} -m0 -U ${uuid_in_fstab} ${devname} -q"
        ;;
      *)
        err "${warn_str}" ; exit 1
        ;;
      esac
      ;;
    *)
      err "${warn_str}" ; exit 1
      ;;
    esac
    ;;
  OpenCloudOS*)
    case "${OS_VERSION}" in
    9*)
      case "${mkfs_bin}" in
      "mkfs.xfs")
        mkfs_cmd="${mkfs_bin} -m uuid=${uuid_in_fstab} -d name=${devname} -f -q"
        ;;
      "mkfs.ext4")
        mkfs_cmd="${mkfs_bin} -m0 -U ${uuid_in_fstab} ${devname} -q"
        ;;
      *)
        err "${warn_str}" ; exit 1
        ;;
      esac
      ;;
    *)
      err "${warn_str}" ; exit 1
      ;;
    esac
    ;;
  *)
    err "${warn_str}" ; exit 1
    ;;
  esac
  ${mkfs_cmd} || {
    err "${action_str}" $(is_ok 0); err "${warn_str}"; exit 1
  }
  info "${action_str}" $(is_ok 1)

  restore_boot_partition
  info "[Convert boot parttion to LUKS1]" $(is_ok 1)
}

convert_boot_partition_to_luks1

lower_iter_on_enc_blk_dev () {
  local enc_blk_dev=$1 enc_passwd=$2
  local iter_nr=300000
  local key_slot_nr=0
  local lower_iter_cmd=""

  info "[Lower iterations to speedup decryption on ${enc_blk_dev}]"

  info "luksDump ${enc_blk_dev}"
  cryptsetup luksDump ${enc_blk_dev}

  action_str="luksChangeKey ${enc_blk_dev}"
  info "${action_str}"
  lower_iter_cmd="cryptsetup luksChangeKey --pbkdf-force-iterations ${iter_nr}"
  lower_iter_cmd="${lower_iter_cmd} --key-slot ${key_slot_nr} ${enc_blk_dev}"
  # update it twice so that it use first slot, input of the command are:
  #   1. old passphrase,
  #   2. new passphrase,
  #   3. passphrase to verify
  ${lower_iter_cmd} <<EOF
${enc_passwd}
${enc_passwd}
${enc_passwd}
EOF
  if [ $? -ne 0 ]; then
    err "${action_str}" $(is_ok 0) ; exit 1
  fi

  info "luksDump ${enc_blk_dev}"
  cryptsetup luksDump ${enc_blk_dev}

#  info "${action_str}"
#  ${lower_iter_cmd} <<EOF
#${enc_passwd}
#${enc_passwd}
#${enc_passwd}
#EOF
#  if [ $? -ne 0 ]; then
#    err "${action_str}" $(is_ok 0)
#    exit 1
#  fi
#
#  info "luksDump ${enc_blk_dev}"
#  cryptsetup luksDump ${enc_blk_dev}

  action_str="Test passphrase on ${enc_blk_dev}"
  info "${action_str}"
  cryptsetup luksOpen --test-passphrase --verbose ${enc_blk_dev} \
    <<< "${enc_passwd}" || {
    err "${action_str}" $(is_ok 0) ; exit 1
  }
  info "${action_str}" $(is_ok 1)

  info "[Lower iterations to speedup decryption on ${enc_blk_dev}]" $(is_ok 1)
}

add_keyfile_for_enc_blk_dev () {
  local enc_blk_dev="$1" enc_part_name="$2" enc_passwd="$3"
  local keyfile="${luks_keyfile_top_dir}/${enc_part_name}.key"

  info "[Add keyfile for device "${enc_blk_dev}"]"

  if [ $(grep -c "^${enc_part_name}.*none.*$" ${crypttab_conf}) -lt 1 ]; then
    info "${crypttab_conf} has setup ${enc_blk_dev} with a keyfile"
    grep "^${enc_part_name}.*$" ${crypttab_conf}
    info "Skip adding keyfile for ${enc_blk_dev}"
    return
  fi

  action_str="Generate the ${keyfile} for ${enc_blk_dev}"
  info "${action_str}"
  if umask 0077 && \
     dd if=/dev/urandom bs=1 count=64 of=${keyfile} conv=excl,fsync; then
    info "${action_str}" $(is_ok 1)
  else
    err "${action_str}" $(is_ok 0) ; exit 1
  fi

  action_str="keyslot-${luks_keyfile_slot} <-> ${keyfile} to unlock ${enc_blk_dev}"
  info "${action_str}"
  cryptsetup luksAddKey --key-slot ${luks_keyfile_slot} \
    ${enc_blk_dev} ${keyfile} <<< "${enc_passwd}" || {
    err "${action_str}" $(is_ok 0) ; exit 1
  }
  info "${action_str}" $(is_ok 1)

  info "luksDump ${enc_blk_dev}"
  cryptsetup luksDump ${enc_blk_dev}

  action_str="Update crypttab for ${enc_blk_dev} to use keyslot-${luks_keyfile_slot}"
  info "${action_str}"
  sed -i \
    "s|^\(${enc_part_name}.*\)none.*$|\1 ${keyfile} luks,discard,key-slot=${luks_keyfile_slot}|g" \
    ${crypttab_conf} || {
    err "${action_str}" $(is_ok 0) ; exit 1
  }
  info "${action_str}" $(is_ok 1)

  info "[Add keyfile for device "${enc_blk_dev}"]" $(is_ok 1)
}

add_keyfile_for_all_enc_blk_devs () {
  info "[Generate key files for encrypted block devices]"

  local enc_blk_dev="" enc_part_name="" enc_passwd=""

  for enc_blk_dev in ${!encrypted_blk_devs_info[@]}; do
    enc_part_name=${encrypted_blk_devs_info["${enc_blk_dev}"]}
    enc_passwd=${blk_devs_enc_passwd["${enc_blk_dev}"]}
    add_keyfile_for_enc_blk_dev "${enc_blk_dev}" "${enc_part_name}" "${enc_passwd}"
  done

  info "[Generate key files for encrypted block devices]" $(is_ok 1)
}

################################################################################
# 1. Enable cryptmount so that grub live in UEFI will mount LUKS boot partition
# 2. Add key file for each encrypted disk partitions so that mount them without
#    manually input disk password.
################################################################################
update_grub_initramfs () {
  info "[Update grub & initramfs]"

  local grub_update_conf_cmd=""
  local grub_install_cmd=""
  local user_grub_efi_mod_dir="./grub/lib/grub/x86_64-efi"
  local user_grub_valid=0
  local is_update_grub=""
  local is_update_initramfs=""

  read -p "force update grub ? [y/Y/n/N] " is_update_grub
  if [ "X$(echo ${is_update_grub} | tr '[:upper:]' '[:lower:]')" != "Xy" ]; then
    info "Skip update grub"
    return
  fi

  action_str="Enable encrypt in grub"
  info "${action_str}"
  if [ -e "${user_grub_tarball}" ]; then
    info "Unpack user-provided grub"
    tar xf ${user_grub_tarball}
    if [ ! -d "${user_grub_efi_mod_dir}" ]; then
      err "${user_grub_tarball} invalid" $(is_ok 0) ; exit 1
    else
      user_grub_valid=1
    fi
  fi
  case "${OS_NAME}" in
  Anolis*)
    case "${OS_VERSION}" in
    23*|8*)
      sed -i "s|\(^GRUB_CMDLINE_LINUX=\"\)\(.*\)\(\"\)$|\1\2 rd.luks.uuid=${boot_blk_dev_enc_part_name} \3|" \
        /etc/default/grub
      sed -i "s|\(^GRUB_ENABLE_BLSCFG=\)true.*$|\1false|" /etc/default/grub
      echo "GRUB_ENABLE_CRYPTODISK=y" | tee -a /etc/default/grub
      grub_update_conf_cmd="${grub_update_bin} -o ${efi_os_dir}/grub.cfg"
      ${grub_update_conf_cmd} || {
        err "${action_str}" $(is_ok 0) ; exit 1
      }
      # Both the /boot/grub2 and /boot/efi/EFI/anolis need to know how to mount
      # a encrypted boot partition.
      cp ${efi_os_dir}/grub.cfg ${grub_conf_output_dir}/grub.cfg
      # For Anolis OS 8.x, the /boot/grub2/grubenv is symbol linked to
      # /boot/efi/EFI/anolis, we need to move grubenv from /boot/efi/EFI/anolis
      # to /boot/grub2/.
      if echo "${OS_VERSION}" | grep -q "^8"; then
        rm -f ${grub_conf_output_dir}/grubenv
        mv ${efi_os_dir}/grubenv ${grub_conf_output_dir}/grubenv
      fi

      if [ ${user_grub_valid} -eq 1 ]; then
        cp -r ${user_grub_efi_mod_dir} ${grub_conf_output_dir}
        # FIXME: ${grub_install_bin} may need to be replaced with the version
        #        in ${user_grub_tarball}
        grub_install_cmd="${grub_install_bin} -d ${user_grub_efi_mod_dir} ${boot_blk_dev%%[0-9]*}"
      else
        grub_install_cmd="${grub_install_bin} ${boot_blk_dev%%[0-9]*}"
      fi
      ;;
    *)
      ;;
    esac
    ;;
  openEuler*)
    case "${OS_VERSION}" in
    24*)
      sed -i "s|\(^GRUB_CMDLINE_LINUX=\"\)\(.*\)\(\"\)$|\1\2 rd.luks.uuid=${boot_blk_dev_enc_part_name} \3|" \
        /etc/default/grub
      sed -i "s|\(^GRUB_ENABLE_BLSCFG=\)true.*$|\1false|" /etc/default/grub
      echo "GRUB_ENABLE_CRYPTODISK=y" | tee -a /etc/default/grub
      grub_update_conf_cmd="${grub_update_bin} -o ${efi_os_dir}/grub.cfg"
      ${grub_update_conf_cmd} || {
        err "${action_str}" $(is_ok 0) ; exit 1
      }
      # Both the /boot/grub2 and /boot/efi/EFI/openEuler need to know how to mount
      # a encrypted boot partition.
      cp ${efi_os_dir}/grub.cfg ${grub_conf_output_dir}/grub.cfg
      # For openEuler 24.x, the /boot/grub2/grubenv is symbol linked to
      # /boot/efi/EFI/openEuler, we need to move grubenv from /boot/efi/EFI/openEuler
      # to /boot/grub2/.
      rm -f ${grub_conf_output_dir}/grubenv
      mv ${efi_os_dir}/grubenv ${grub_conf_output_dir}/grubenv

      if [ ${user_grub_valid} -eq 1 ]; then
        cp -r ${user_grub_efi_mod_dir} ${grub_conf_output_dir}
        # FIXME: ${grub_install_bin} may need to be replaced with the version
        #        in ${user_grub_tarball}
        grub_install_cmd="${grub_install_bin} -d ${user_grub_efi_mod_dir} ${boot_blk_dev%%[0-9]*}"
      else
        grub_install_cmd="${grub_install_bin} ${boot_blk_dev%%[0-9]*}"
      fi
      ;;
    *)
      ;;
    esac
    ;;
  OpenCloudOS*)
    case "${OS_VERSION}" in
    9*)
      sed -i "s|\(^GRUB_CMDLINE_LINUX=\"\)\(.*\)\(\"\)$|\1\2 rd.luks.uuid=${boot_blk_dev_enc_part_name} \3|" \
        /etc/default/grub
      sed -i "s|\(^GRUB_ENABLE_BLSCFG=\)true.*$|\1false|" /etc/default/grub
      echo "GRUB_ENABLE_CRYPTODISK=y" | tee -a /etc/default/grub
      grub_update_conf_cmd="${grub_update_bin} -o ${efi_os_dir}/grub.cfg"
      ${grub_update_conf_cmd} || {
        err "${action_str}" $(is_ok 0) ; exit 1
      }
      # Both the /boot/grub2 and /boot/efi/EFI/opencloudos need to know how to mount
      # a encrypted boot partition.
      cp ${efi_os_dir}/grub.cfg ${grub_conf_output_dir}/grub.cfg

      if [ ${user_grub_valid} -eq 1 ]; then
        cp -r ${user_grub_efi_mod_dir} ${grub_conf_output_dir}
        # FIXME: ${grub_install_bin} may need to be replaced with the version
        #        in ${user_grub_tarball}
        grub_install_cmd="${grub_install_bin} -d ${user_grub_efi_mod_dir} ${boot_blk_dev%%[0-9]*}"
      else
        grub_install_cmd="${grub_install_bin} ${boot_blk_dev%%[0-9]*}"
      fi
      ;;
    *)
      ;;
    esac
    ;;
  *)
    ;;
  esac

  ${grub_install_cmd} || warn "${action_str}\033[33m
    !!!
    You should notice it when the full disk encryption doesn't work properly
    !!!\033[0m"
  info "${action_str}" $(is_ok 1)
  info "Dump grub.cfg:\n$(grep cryptodisk ${grub_conf_output_dir}/grub.cfg)"

  # Speedup decryption for boot partition
  lower_iter_on_enc_blk_dev ${boot_blk_dev} ${boot_blk_dev_enc_passwd}

  read -p "force update initramfs ? [y/Y/n/N] " is_update_initramfs
  if [ "X$(echo ${is_update_initramfs} | tr '[:upper:]' '[:lower:]')" != "Xy" ]; then
    info "Skip update initramfs"
    return
  fi

  # Add keyfile to keyslot for all the encrypted block devices
  mkdir -m0700 ${luks_keyfile_top_dir} || true
  # Add keyfile for boot partition in advance
  add_keyfile_for_enc_blk_dev ${boot_blk_dev} \
      ${boot_blk_dev_enc_part_name} ${boot_blk_dev_enc_passwd}
  add_keyfile_for_all_enc_blk_devs

  # Note: Add keyfile to conf-hook before update initramfs
  action_str="Setup password of encrypted partitions for initramfs"
  info "${action_str}"
  case "${OS_NAME}" in
  Anolis*)
    case "${OS_VERSION}" in
    23*|8*)
      echo "install_items+=\" /etc/keys/*.key \"" | tee -a /etc/dracut.conf.d/cryptodisk.conf
      dracut --force || {
        err "${action_str}" $(is_ok 0) ; exit 1
      }
      ;;
    *)
      ;;
    esac
    ;;
  openEuler*)
    case "${OS_VERSION}" in
    24*)
      echo "install_items+=\" /etc/keys/*.key \"" | tee -a /etc/dracut.conf.d/cryptodisk.conf
      dracut --force || {
        err "${action_str}" $(is_ok 0) ; exit 1
      }
      ;;
    *)
      ;;
    esac
    ;;
  OpenCloudOS*)
    case "${OS_VERSION}" in
    9*)
      echo "install_items+=\" /etc/keys/*.key \"" | tee -a /etc/dracut.conf.d/cryptodisk.conf
      dracut --force || {
        err "${action_str}" $(is_ok 0) ; exit 1
      }
      ;;
    *)
      ;;
    esac
    ;;
  *)
    ;;
  esac

  info "${action_str}" $(is_ok 1)
}

update_grub_initramfs

# Accept Ctrl+C
trap - SIGINT
