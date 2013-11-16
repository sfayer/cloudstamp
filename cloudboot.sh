#!/bin/sh

# Halt on any errors
set -e

# Memory to use for this boot
INST_MEM=2048

## Attempt to find a qemu version we can use
if [ `which qemu-kvm 2>&-` ]; then
  QEMU_BIN=`which qemu-kvm`
else
  QEMU_BIN=`which qemu-system-x86_64`
fi

# Check the arguments
if [ "$#" -ne "2" ]; then
  echo "Usage: cloudboot.sh ostype config " >&2
  # TODO: Known types
  exit 1
fi
OS_NAME="${1}"
CONF_NAME="${2}"
IMG_NAME=${CONF_NAME}-${OS_NAME}.img

echo "Reminder: Press "Ctrl-a x" to kill the VM."
echo "          (See man qemu for more shortcuts)."

${QEMU_BIN} -nographic \
            -m ${INST_MEM} \
            -drive "file=output/${IMG_NAME},if=virtio" \
            -net nic,model=virtio -net user

