#!/bin/sh

# Download some common Linux variant install images
# Four linuxes, three initrd compression methods!
set -e # Stop on errors
mkdir -p boot

# CentOS 6.5 (LZMA)
if [ ! -e boot/centos65_vmlinuz ]; then
  wget -O boot/centos65_vmlinuz \
    "http://www.mirrorservice.org/sites/mirror.centos.org/6.5/os/x86_64/images/pxeboot/vmlinuz"
fi
if [ ! -e boot/centos65_initrd.img ]; then
  wget -O boot/centos65_initrd.img.lzma \
    "http://www.mirrorservice.org/sites/mirror.centos.org/6.5/os/x86_64/images/pxeboot/initrd.img"
  echo "Recompressing CentOS 6.5 initrd..." >&2
  unlzma boot/centos65_initrd.img.lzma
  gzip -9 boot/centos65_initrd.img
  mv boot/centos65_initrd.img.gz boot/centos65_initrd.img
fi

# Scientific Linux 6.4 (LZMA)
if [ ! -e boot/sl64_vmlinuz ]; then
  wget -O boot/sl64_vmlinuz \
    "http://www.mirrorservice.org/sites/ftp.scientificlinux.org/linux/scientific/6/x86_64/os/images/pxeboot/vmlinuz"
fi
if [ ! -e boot/sl64_initrd.img ]; then
  wget -O boot/sl64_initrd.img.lzma \
    "http://www.mirrorservice.org/sites/ftp.scientificlinux.org/linux/scientific/6/x86_64/os/images/pxeboot/initrd.img"
  echo "Recompressing Scientific Linux 6.4 initrd..." >&2
  unlzma boot/sl64_initrd.img.lzma
  gzip -9 boot/sl64_initrd.img
  mv boot/sl64_initrd.img.gz boot/sl64_initrd.img
fi



# CentOS 5.10 (GZIP)
if [ ! -e boot/centos510_vmlinuz ]; then
  wget -O boot/centos510_vmlinuz \
    "http://www.mirrorservice.org/sites/mirror.centos.org/5.10/os/x86_64/images/pxeboot/vmlinuz"
fi
if [ ! -e boot/centos510_initrd.img ]; then
  wget -O boot/centos510_initrd.img \
    "http://www.mirrorservice.org/sites/mirror.centos.org/5.10/os/x86_64/images/pxeboot/initrd.img"
  # Already in the right format
fi

# Fedora 19 (XZ)
if [ ! -e boot/fedora19_vmlinuz ]; then
  wget -O boot/fedora19_vmlinuz \
    "http://download.fedoraproject.org/pub/fedora/linux/releases/19/Fedora/x86_64/os/images/pxeboot/vmlinuz"
fi
if [ ! -e boot/fedora19_initrd.img ]; then
  wget -O boot/fedora19_initrd.img.xz \
    "http://download.fedoraproject.org/pub/fedora/linux/releases/19/Fedora/x86_64/os/images/pxeboot/initrd.img"
  echo "Recompressing Fedora 19 initrd..." >&2
  unxz boot/fedora19_initrd.img.xz
  gzip -9 boot/fedora19_initrd.img
  mv boot/fedora19_initrd.img.gz boot/fedora19_initrd.img
fi

# TODO: Will these checksums always match? We're recompessing some files and
#       that's probably dependent on the machine doing the compressing...
echo "Verifying checksums..." >&2
sha1sum -c << EOF
af4add14b6f75dd2e83285247d38b2b7719e2bde  boot/centos510_initrd.img
a492381a2e5ccea8ae620c498c3e7787948014c8  boot/centos510_vmlinuz
4c3fcff9f06fa7fae06c45271ced9946073d125f  boot/centos65_initrd.img
a7a245d687eff671ed5e5b2800f416b696f6715f  boot/centos65_vmlinuz
62074215b816975c28eb79b355551a34bf6082f6  boot/sl64_initrd.img
d790f5599e0a7a30183961bab3265e7441f40748  boot/sl64_vmlinuz
b0d0a0193884a6d734162cf702243a1c993e9d06  boot/fedora19_initrd.img
1331d45ae30ab6885104387a71b1cba33f789541  boot/fedora19_vmlinuz
EOF

