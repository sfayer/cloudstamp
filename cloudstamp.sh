#!/bin/sh

# Halt on any errors
set -e

# Constants
# The OS disk size
IMG_SIZE=20G
# The installer memory provision
# Careful: This will probably affect the image swap size
INST_MEM=2048

# Find the tools
QEMU_IMG_BIN=`which qemu-img`
# Attempt to find a qemu version we can use
if [ `which qemu-kvm 2>&-` -a -e "/dev/kvm" ]; then
  QEMU_BIN=`which qemu-kvm`
else
  QEMU_BIN=`which qemu-system-x86_64`
fi
GZIP_BIN=`which gzip`

# Check the arguments
if [ "$#" -ne "2" ]; then
  echo "Usage: cloudstamp.sh ostype config " >&2
  # TODO: Known types
  exit 1
fi
OS_NAME="${1}"
CONF_NAME="${2}"
IMG_NAME=${CONF_NAME}-${OS_NAME}.img
OUTDIR=output
TMPDIR=${OUTDIR}/tmp-${CONF_NAME}-${OS_NAME}

# Check the config actually exists to prevent mistakes 
if [ ! -f "config/nodes/${CONF_NAME}.pp" ]; then
  echo "Error: config/nodes/${CONF_NAME}.pp not found." >&2
  exit 1
fi

# Update our initrd
echo "[*] Injecting files into initrd..." >&2
rm -rf ${TMPDIR}
mkdir -p ${TMPDIR}
cp boot/${OS_NAME}_initrd.img ${TMPDIR}/initrd.tmp.gz
${GZIP_BIN} -d ${TMPDIR}/initrd.tmp.gz
find config -print | cpio --quiet -ocAO ${TMPDIR}/initrd.tmp
${GZIP_BIN} -9 ${TMPDIR}/initrd.tmp

echo "[*] Creating disk image..." >&2
${QEMU_IMG_BIN} create -f qcow2 "${TMPDIR}/${IMG_NAME}" ${IMG_SIZE} >&-
echo "[*] Booting Installer..." >&2
${QEMU_BIN} -nographic \
            -m ${INST_MEM} \
            -kernel boot/${OS_NAME}_vmlinuz \
            -initrd ${TMPDIR}/initrd.tmp.gz \
            -append "console=ttyS0 ks=file:/config/ks/${OS_NAME}.cfg ksc=${CONF_NAME}" \
            -drive "file=${TMPDIR}/${IMG_NAME},if=virtio" \
            -net nic,model=virtio -net user
echo "[*] Welcome back... Resetting your console in 3 seconds." >&2
sleep 3; reset
echo "[*] Compressing image..." >&2
${QEMU_IMG_BIN} convert -c -O qcow2 "${TMPDIR}/${IMG_NAME}" "${OUTDIR}/${IMG_NAME}"
echo "[*] Tidying up..." >&2
rm -rf ${TMPDIR}
echo "[*] Complete." >&2
echo "Your image file is here: ${OUTDIR}/${IMG_NAME}"

