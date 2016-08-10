#!/bin/sh

# Download some common Linux variant install images
# Four linuxes, three initrd compression methods!
set -e # Stop on errors
mkdir -p boot

# CentOS 6.8 (LZMA)
if [ ! -e boot/centos68_vmlinuz ]; then
  wget -O boot/centos68_vmlinuz \
    "http://www.mirrorservice.org/sites/mirror.centos.org/6.8/os/x86_64/images/pxeboot/vmlinuz"
fi
if [ ! -e boot/centos68_initrd.img ]; then
  wget -O boot/centos68_initrd.img.lzma \
    "http://www.mirrorservice.org/sites/mirror.centos.org/6.8/os/x86_64/images/pxeboot/initrd.img"
  echo "Recompressing CentOS 6.8 initrd..." >&2
  unlzma boot/centos68_initrd.img.lzma
  gzip -9 boot/centos68_initrd.img
  mv boot/centos68_initrd.img.gz boot/centos68_initrd.img
fi

# Scientific Linux 6.8 (LZMA)
if [ ! -e boot/sl68_vmlinuz ]; then
  wget -O boot/sl68_vmlinuz \
    "http://www.mirrorservice.org/sites/ftp.scientificlinux.org/linux/scientific/6/x86_64/os/images/pxeboot/vmlinuz"
fi
if [ ! -e boot/sl68_initrd.img ]; then
  wget -O boot/sl68_initrd.img.lzma \
    "http://www.mirrorservice.org/sites/ftp.scientificlinux.org/linux/scientific/6/x86_64/os/images/pxeboot/initrd.img"
  echo "Recompressing Scientific Linux 6.8 initrd..." >&2
  unlzma boot/sl68_initrd.img.lzma
  gzip -9 boot/sl68_initrd.img
  mv boot/sl68_initrd.img.gz boot/sl68_initrd.img
fi



# CentOS 5.11 (GZIP)
if [ ! -e boot/centos511_vmlinuz ]; then
  wget -O boot/centos511_vmlinuz \
    "http://www.mirrorservice.org/sites/mirror.centos.org/5.11/os/x86_64/images/pxeboot/vmlinuz"
fi
if [ ! -e boot/centos511_initrd.img ]; then
  wget -O boot/centos511_initrd.img \
    "http://www.mirrorservice.org/sites/mirror.centos.org/5.11/os/x86_64/images/pxeboot/initrd.img"
  # Already in the right format
fi

# TODO: Will these checksums always match? We're recompessing some files and
#       that's probably dependent on the machine doing the compressing...
echo "Verifying checksums..." >&2
sha1sum -c << EOF
957730e883af19dde3a615c542f3ec3751c18b03  boot/centos511_initrd.img
c65aa075bd344099e0093bca21a481764f495c3a  boot/centos511_vmlinuz
7e777595e458e6e965c04b2960739c67fec5d0fe  boot/centos68_initrd.img
13e159e407610411851f32e040e800e6e2918162  boot/centos68_vmlinuz
9f4da85f793771614bca9cf3fe07f3063b6474dd  boot/sl68_initrd.img
81b61e417f49ac052f094e10d9abe80ca63bfc72  boot/sl68_vmlinuz

EOF

