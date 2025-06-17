#!/bin/bash

# generate-hygon-cc-launch-blobs.sh

DEBUG=${DEBUG:-0}

if [ ${DEBUG} -eq 1 ]; then
  set -x
fi

kernel_path=""
initrd_path=""
cmdline_path=""
ovmf_path=""
hygon_cctype="csv"
hag_path=""
secret=""
secret_tool="$(pwd)/pack-secret.py"
blobtype=""

workspace=""

hag_cctype_policy_opts=""
hag_kernel_opts=""
hag_initrd_opts=""
hag_cmdline_opts=""

usage () {
  set +x
  echo -e "\033[31m
Usage: $0 <-h|-f <ovmf-path> -C <hygon-cctype> -H <hag-tool-path> -s <secret>
              -p <secret-pack-tool> -k <kernel-path> -i <initrd-path> -c <cmdline-path> -B <blobtype>>

       -h,--help       Display this help message
       -f,--ovmf       The path of the guest OVMF
       -C,--cctype     The Hygon Confidential-Computing VM type
                       Valid value are shown as following:
                           csv  (i.e. CSV1 VM)
                           csv1 (i.e. CSV1 VM)
                           csv2 (i.e. CSV2 VM)
                           csv3 (i.e. CSV3 VM)
                       Default is csv
       -H,--hag        The path of the hag tool
       -s,--secret     The secret tobe injected to the guest
       -p,--packtool   The tool to pack the secret, you should pack the secret before
                       injecting it to the guest
       -k,--kernel     The path of the guest kernel
       -i,--initrd     The path of the guest initrd
       -c,--cmdline    The path of the guest cmdline
       -B,--blobtype   The generated blob type
                       Valid values are as follows:
                           FDE (i.e. Full-Disk-Encryption)
                           Kernel-Hashes
                           Sealing-Key
\033[0m"
  set -x
}

err () {
  echo -e "\033[31;1m[Error]\033[0m $*"
}

info () {
  echo -e "\033[33;1m[Info]\033[0m $*"
}

is_ok () {
  local val=$1

  if [ ${val} -eq 1 ]; then
    echo -ne "\033[32;1m [Ok]\033[0m"
  else
    echo -ne "\033[31;1m [x]\033[0m"
  fi
}

params=$(getopt -o -hf:C:H:s:p:k:i:c:B: --long help,ovmf:,cctype:,hag:,secret:,packtool:,kernel:,initrd:,cmdline:,blobtype: -- "$@")
if [ $? -ne 0 ]; then
  err "cannot parse parameters" ; usage ; exit 1
fi

eval set -- "$params"

while true; do
  case "$1" in
  -h|--help)
    usage ; exit 0
    ;;
  -f|--ovmf)
    ovmf_path="$2"
    shift 2
    ;;
  -C|--cctype)
    hygon_cctype="$2"
    shift 2
    ;;
  -H|--hag)
    hag_path="$2"
    shift 2
    ;;
  -s|--secret)
    secret="$2"
    shift 2
    ;;
  -p|--packtool)
    secret_tool="$2"
    shift 2
    ;;
  -k|--kernel)
    kernel_path="$2"
    shift 2
    ;;
  -i|--initrd)
    initrd_path="$2"
    shift 2
    ;;
  -c|--cmdline)
    cmdline_path="$2"
    shift 2
    ;;
  -B|--blobtype)
    blobtype="$2"
    shift 2
    ;;
  --)
    shift
    break
    ;;
  *)
    usage ; exit 1
    ;;
  esac
done

prepare_generate_launch_blobs () {
  if [ -z "${hag_path}" ] ||
     [ ! -e "${hag_path}" ] ||
     [ -z "${ovmf_path}" ] ||
     [ ! -e "${ovmf_path}" ]; then
    err "Missing OVMF or hag" ; usage ; exit 1
  fi
  hag_path=$(realpath ${hag_path})
  ovmf_path=$(realpath ${ovmf_path})

  if [ -z "${blobtype}" ]; then
    err "Missing BlobType" ; usage ; exit 1
  else
    case "$(echo ${blobtype} | tr '[:upper:]' '[:lower:]')" in
    "fde")
      workspace=Full-Disk-Encryption-workspace
      if [ -z "${secret}" ] ||
         [ -z "${secret_tool}" ] ||
         [ ! -e "${secret_tool}" ]; then
        err "Missing secret or secret-pack-tool" ; usage ; exit 1
      fi
      secret_tool=$(realpath ${secret_tool})
      ;;
    "kernel-hashes")
      workspace=Kernel-hashes-workspace
      ;;
    "sealing-key")
      workspace=Sealing-Key-workspace
      ;;
    *)
      workspace=Generate-launch-blobs-workspace
      ;;
    esac
  fi

  case "${hygon_cctype}" in
  "csv"|"csv1")
    hag_cctype_policy_opts=""
    ;;
  "csv2")
    hag_cctype_policy_opts=" -es"
    ;;
  "csv3")
    hag_cctype_policy_opts=" -es -csv3"
    ;;
  *)
    err "Unknown Hygon CC type" ; usage ; exit 1
    ;;
  esac

  if [ -n "${kernel_path}" ]; then
    [ -e "${kernel_path}" ] || {
      err "Missing kernel file" ; usage ; exit 1
    }
    kernel_path=$(realpath ${kernel_path})
    hag_kernel_opts=" -kernel ${kernel_path}"
  fi
  if [ -n "${initrd_path}" ]; then
    [ -e "${initrd_path}" ] || {
      err "Missing initrd file" ; usage ; exit 1
    }
    initrd_path=$(realpath ${initrd_path})
    hag_initrd_opts=" -initrd ${initrd_path}"
  fi
  if [ -n "${cmdline_path}" ]; then
    [ -e "${cmdline_path}" ] || {
      err "Missing cmdline file" ; usage ; exit 1
    }
    cmdline_path=$(realpath ${cmdline_path})
    hag_cmdline_opts=" -cmdline ${cmdline_path}"
  fi

  rm -rf ${workspace} || true
  mkdir ${workspace}
}

prepare_generate_launch_blobs

do_generate_launch_blobs () {
  cd ${workspace}

  build_id=$(sudo ${hag_path} csv platform_status | grep "build id")
  build_id=$(echo ${build_id##*:})
  sudo ${hag_path} csv pdh_cert_export
  # Generate police in advance
  ${hag_path} csv generate_policy -nodebug ${hag_cctype_policy_opts}

  case "$(echo ${blobtype} | tr '[:upper:]' '[:lower:]')" in
  "fde")
    case "${hygon_cctype}" in
    "csv"|"csv1"|"csv2")
      ${hag_path} csv generate_launch_blob \
        -build ${build_id} \
        -bios ${ovmf_path}
      ;;
    "csv3")
      ${hag_path} csv generate_launch_blob \
        -build ${build_id} \
        -bios ${ovmf_path} \
        -cpu 'Dhyana-v1' -smp 4
      ;;
    esac
    tr -d '\n' < guest_owner_dh.cert > dh_cert.base64
    tr -d '\n' < launch_blob.bin > session.base64

    sed -i "s!\<HAG_PATH\>!${hag_path}!" ${secret_tool}
    ${secret_tool} --secret ${secret} --build ${build_id}
    sed -i "s!${hag_path}!HAG_PATH!" ${secret_tool}
    base64 -w 0 secret.bin > secret.bin.b64
    base64 -w 0 secret_header.bin > secret_header.bin.b64
    ;;
  *)
    case "${hygon_cctype}" in
    "csv"|"csv1"|"csv2")
      ${hag_path} csv generate_launch_blob \
        -build ${build_id} \
        -bios ${ovmf_path} \
        ${hag_kernel_opts} \
        ${hag_initrd_opts} \
        ${hag_cmdline_opts}
      ;;
    "csv3")
      ${hag_path} csv generate_launch_blob \
        -build ${build_id} \
        -bios ${ovmf_path} \
        ${hag_kernel_opts} \
        ${hag_initrd_opts} \
        ${hag_cmdline_opts} \
        -cpu 'Dhyana-v1' -smp 4
      ;;
    esac
    ;;
  esac
}

do_generate_launch_blobs
