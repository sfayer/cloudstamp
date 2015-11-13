#!/bin/sh

# Download some common Linux variant install images
# Four linuxes, three initrd compression methods!
set -e # Stop on errors
mkdir -p boot

# CentOS 6.7 (LZMA)
if [ ! -e boot/centos67_vmlinuz ]; then
  wget -O boot/centos67_vmlinuz \
    "http://www.mirrorservice.org/sites/mirror.centos.org/6.7/os/x86_64/images/pxeboot/vmlinuz"
fi
if [ ! -e boot/centos67_initrd.img ]; then
  wget -O boot/centos67_initrd.img.lzma \
    "http://www.mirrorservice.org/sites/mirror.centos.org/6.7/os/x86_64/images/pxeboot/initrd.img"
  echo "Recompressing CentOS 6.7 initrd..." >&2
  unlzma boot/centos67_initrd.img.lzma
  gzip -9 boot/centos67_initrd.img
  mv boot/centos67_initrd.img.gz boot/centos67_initrd.img
fi

# Scientific Linux 6.7 (LZMA)
if [ ! -e boot/sl67_vmlinuz ]; then
  wget -O boot/sl67_vmlinuz \
    "http://www.mirrorservice.org/sites/ftp.scientificlinux.org/linux/scientific/6/x86_64/os/images/pxeboot/vmlinuz"
fi
if [ ! -e boot/sl67_initrd.img ]; then
  wget -O boot/sl67_initrd.img.lzma \
    "http://www.mirrorservice.org/sites/ftp.scientificlinux.org/linux/scientific/6/x86_64/os/images/pxeboot/initrd.img"
  echo "Recompressing Scientific Linux 6.7 initrd..." >&2
  unlzma boot/sl67_initrd.img.lzma
  gzip -9 boot/sl67_initrd.img
  mv boot/sl67_initrd.img.gz boot/sl67_initrd.img
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

# Fedora 20 (XZ)
if [ ! -e boot/fedora20_vmlinuz ]; then
  wget -O boot/fedora20_vmlinuz \
    "http://download.fedoraproject.org/pub/fedora/linux/releases/20/Fedora/x86_64/os/images/pxeboot/vmlinuz"
fi
if [ ! -e boot/fedora20_initrd.img ]; then
  wget -O boot/fedora20_initrd.img.xz \
    "http://download.fedoraproject.org/pub/fedora/linux/releases/20/Fedora/x86_64/os/images/pxeboot/initrd.img"
  echo "Recompressing Fedora 20 initrd..." >&2
  unxz boot/fedora20_initrd.img.xz
  gzip -9 boot/fedora20_initrd.img
  mv boot/fedora20_initrd.img.gz boot/fedora20_initrd.img
fi

# TODO: Will these checksums always match? We're recompessing some files and
#       that's probably dependent on the machine doing the compressing...
echo "Verifying checksums..." >&2
sha1sum -c << EOF
957730e883af19dde3a615c542f3ec3751c18b03  boot/centos511_initrd.img
c65aa075bd344099e0093bca21a481764f495c3a  boot/centos511_vmlinuz
92909fef6a8e401f5d467867d3c8a58ac5e05595  boot/centos67_initrd.img
f7e7bcb4f46bb73fe2daba90dc7a564072cfb43f  boot/centos67_vmlinuz
b58beec5ad85d735980fd435a2a74b174ca10e65  boot/sl67_initrd.img
9b386b46401cb96a1a6860b823b3517f1afbbaee  boot/sl67_vmlinuz

7165db4aedb5dcbb1436e9597c910508b2a002e3  boot/fedora20_initrd.img
fb56dd066b7b2017b634b09f16736ee23f1e32cd  boot/fedora20_vmlinuz
EOF

