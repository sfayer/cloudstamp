#!/bin/sh

# Download some common Linux variant install images
# Four linuxes, three initrd compression methods!
set -e # Stop on errors
mkdir -p boot

# CentOS 6.6 (LZMA)
if [ ! -e boot/centos66_vmlinuz ]; then
  wget -O boot/centos66_vmlinuz \
    "http://www.mirrorservice.org/sites/mirror.centos.org/6.6/os/x86_64/images/pxeboot/vmlinuz"
fi
if [ ! -e boot/centos66_initrd.img ]; then
  wget -O boot/centos66_initrd.img.lzma \
    "http://www.mirrorservice.org/sites/mirror.centos.org/6.6/os/x86_64/images/pxeboot/initrd.img"
  echo "Recompressing CentOS 6.6 initrd..." >&2
  unlzma boot/centos66_initrd.img.lzma
  gzip -9 boot/centos66_initrd.img
  mv boot/centos66_initrd.img.gz boot/centos66_initrd.img
fi

# Scientific Linux 6.6 (LZMA)
if [ ! -e boot/sl66_vmlinuz ]; then
  wget -O boot/sl66_vmlinuz \
    "http://www.mirrorservice.org/sites/ftp.scientificlinux.org/linux/scientific/6/x86_64/os/images/pxeboot/vmlinuz"
fi
if [ ! -e boot/sl66_initrd.img ]; then
  wget -O boot/sl66_initrd.img.lzma \
    "http://www.mirrorservice.org/sites/ftp.scientificlinux.org/linux/scientific/6/x86_64/os/images/pxeboot/initrd.img"
  echo "Recompressing Scientific Linux 6.6 initrd..." >&2
  unlzma boot/sl66_initrd.img.lzma
  gzip -9 boot/sl66_initrd.img
  mv boot/sl66_initrd.img.gz boot/sl66_initrd.img
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
6d24806c2b4f9f7679ee803e68223965b71bcaf4  boot/centos66_initrd.img
ef0d91c733e2422c523b50b3718f7cb50bb0f023  boot/centos66_vmlinuz
3b079e955553e5f1f766877ff87b9ef2052f1791  boot/sl66_initrd.img
c682c7cac71f233bcb816c5ae68de8646a9f41e3  boot/sl66_vmlinuz
e7fe8d12649dfcae456d977cd42ad1176ec9a2e0  boot/fedora20_initrd.img
fb56dd066b7b2017b634b09f16736ee23f1e32cd  boot/fedora20_vmlinuz
EOF

