#!/bin/bash

DEBUG=${DEBUG:-0}
QEMU_INSTALL_TOP_DIR=${QEMU_INSTALL_TOP_DIR:-""}

if [ ${DEBUG} -eq 1 ]; then
  set -x
fi

is_install_vm=0
is_launch_vm=0
iso_path=""
ovmf_path=""
vm_qcow2_path=""
vm_qcow2_size="60G"
hygon_cctype="norm"

qemu_img_bin=""
qemu_kvm_bin=""

qemu_ovmf_cmd=""
qemu_vm_blk_dev_cmd=""
qemu_iso_cmd=""
qemu_csv_policy=""
qemu_hygon_cc_cmd=""

usage () {
  set +x
  echo -e "\033[31m
Usage: $0 <-h|<-I -i <iso-path> [-s <vm-qcow2-size>]|-L> -f <ovmf-path> -d <vm-qcow2-path> [-C <hygon-cctype>]>

       -h,--help      Display this help message
       -I,--install   Install a VM
       -i,--iso       The ISO to install OS to the qcow2
       -s,--qcow2size The size of the VM's qcow2
                      Default is 60G
       -L,--launch    Launch a VM
       -f,--ovmf      The path of the VM's OVMF
       -d,--vmqcow2   The path of the VM's qcow2
       -C,--cctype    The Hygon Confidential-Computing VM type
                      Valid value are shown as following:
                          norm (i.e. Non-CC VM)
                          csv  (i.e. CSV1 VM)
                          csv1 (i.e. CSV1 VM)
                          csv2 (i.e. CSV2 VM)
                          csv3 (i.e. CSV3 VM)
                      Default is norm
\033[0m"
  set -x
}

err () {
  echo -e "\033[31;1m[Error]\033[0m $*"
}

params=$(getopt -o hIi:s:Lf:d:C: --long help,install,iso:,qcow2size:,launch,ovmf:,vmqcow2:cctype: -- "$@")
if [ $? -ne 0 ]; then
  err "Cannot parse parameters" ; usage ; exit 1
fi

eval set -- "$params"

while true; do
  case "$1" in
  -h|--help)
    usage
    exit 0
    ;;
  -I|--install)
    is_install_vm=1
    shift
    ;;
  -L|--launch)
    is_launch_vm=1
    shift
    ;;
  -i|--iso)
    iso_path="$2"
    shift 2
    ;;
  -f|--ovmf)
    ovmf_path="$2"
    shift 2
    ;;
  -d|--vmqcow2)
    vm_qcow2_path="$2"
    shift 2
    ;;
  -s|--qcow2size)
    vm_qcow2_size="$2"
    shift 2
    ;;
  -C|--cctype)
    hygon_cctype="$2"
    shift 2
    ;;
  --)
    shift
    break
    ;;
  *)
    usage
    exit 1
    ;;
  esac
done

prepare_install_or_launch () {
  if [ -z "${QEMU_INSTALL_TOP_DIR}" ]; then
    command -v qemu-img > /dev/null || {
      err "You need provide env var QEMU_INSTALL_TOP_DIR" ; exit 1
    }
    command -v qemu-system-x86_64 > /dev/null || {
      err "You need provide env var QEMU_INSTALL_TOP_DIR" ; exit 1
    }
    qemu_img_bin="$(which qemu-img)"
    qemu_kvm_bin="$(which qemu-system-x86_64)"
  else
    qemu_img_bin="${QEMU_INSTALL_TOP_DIR}/bin/qemu-img"
    qemu_kvm_bin="${QEMU_INSTALL_TOP_DIR}/bin/qemu-system-x86_64"
    command -v ${qemu_img_bin} > /dev/null || {
      err "env var QEMU_INSTALL_TOP_DIR is invalid" ; exit 1
    }
    command -v ${qemu_kvm_bin} > /dev/null || {
      err "env var QEMU_INSTALL_TOP_DIR is invalid" ; exit 1
    }
  fi

  if [ -z "${ovmf_path}" ] ||
     [ ! -e "${ovmf_path}" ]; then
    err "Missing OVMF" ; usage ; exit 1
  fi

  # If install, the ${iso_path} and ${vm_qcow2_path} must be valid
  if [ ${is_install_vm} -eq 1 ]; then
    if [ "X${iso_path}" = "X" ] ||
       [ ! -e "${iso_path}" ] ||
       [ "X${vm_qcow2_path}" = "X" ]; then
      err "Missing ISO or VM's qcow2" ; usage ; exit 1
    fi
    [ ! -d $(dirname ${vm_qcow2_path}) ] || {
      mkdir -p $(dirname ${vm_qcow2_path})
    }

    ${qemu_img_bin} create -f qcow2 ${vm_qcow2_path} ${vm_qcow2_size}

    qemu_iso_cmd="-cdrom ${iso_path}"
  else
    if [ -z "${vm_qcow2_path}" ] ||
       [ ! -e ${vm_qcow2_path} ]; then
      err "Missing VM's qcow2" ; usage ; exit 1
    fi
  fi

  case "${hygon_cctype}" in
  "norm")
    ;;
  "csv"|"csv1")
    qemu_csv_policy="0x1"
    ;;
  "csv2")
    qemu_csv_policy="0x5"
    ;;
  "csv3")
    qemu_csv_policy="0x45"
    ;;
  *)
    usage ; exit 1
    ;;
  esac
}

prepare_install_or_launch

do_install_or_launch_vm () {
  qemu_ovmf_cmd="
   -drive if=pflash,format=raw,unit=0,file=${ovmf_path},readonly=on"
  qemu_vm_blk_dev_cmd="
   -device virtio-scsi-pci,id=scsi0,disable-legacy=on,iommu_platform=on
   -drive file=${vm_qcow2_path},if=none,id=drive.0
   -device scsi-hd,bus=scsi0.0,id=scsi-hd.0,drive=drive.0"

  if [ "X${qemu_csv_policy}" != "X" ]; then
    qemu_hygon_cc_cmd="
   -object sev-guest,id=sev0,cbitpos=47,reduced-phys-bits=5,policy=${qemu_csv_policy}
   -machine memory-encryption=sev0"
  fi

  sudo ${qemu_kvm_bin} \
    -enable-kvm \
    -machine q35 \
    -cpu host \
    -smp 16 \
    -m 8G \
    ${qemu_ovmf_cmd} \
    -boot d \
    ${qemu_iso_cmd} \
    ${qemu_vm_blk_dev_cmd} \
    ${qemu_hygon_cc_cmd} \
    -vnc 0.0.0.0:0,to=100
}

do_install_or_launch_vm
