
class wlcg
{
  # We could load the repo here and just install the HEP_OSlibs package
  # BUT they didn't GPG sign it, so it doesn't meet my security guidelines
  # We'll do this the hard way
  if $architecture == 'x86_64'
  {
    $base_packages = [ 'compat-glibc',   'compat-glibc-headers', 'device-mapper',
                       'kernel-headers', 'mesa-dri1-drivers',    'ncurses',
                       'xorg-x11-proto-devel', 'perl-ExtUtils-Embed', 'perl-CGI',
                       'tcsh', 'zsh', 'procmail', 'autoconf', 'automake',
                       'libtool', 'bind-utils', 'gcc-c++'
                     ]
     # I'm sure there is a better way of doing this...
     $ml_packages = [ 'alsa-lib.i686', 'audit-libs.i686', 'bzip2-libs.i686',
                      'compat-db.i686', 'compat-db42.i686', 'compat-db43.i686',
                      'compat-libf2c-34.i686', 'compat-libstdc++-33.i686',
                      'compat-libtermcap.i686', 'compat-openldap.i686',
                      'compat-readline5.i686', 'cracklib.i686', 'cyrus-sasl-lib.i686',
                      'db4.i686', 'e2fsprogs-libs.i686', 'expat.i686',
                      'fontconfig.i686', 'freetype.i686', 'gamin.i686', 'gdbm.i686',
                      'giflib.i686', 'glib2.i686', 'glibc.i686', 'glibc-devel.i686',
                      'gmp.i686', 'keyutils-libs.i686', 'krb5-libs.i686', 'libICE.i686',
                      'libSM.i686', 'libX11.i686', 'libXau.i686', 'libXcursor.i686',
                      'libXdamage.i686', 'libXdmcp.i686', 'libXext.i686', 'libXfixes.i686',
                      'libXft.i686', 'libXi.i686', 'libXinerama.i686', 'libXmu.i686',
                      'libXp.i686', 'libXpm.i686', 'libXrandr.i686', 'libXrender.i686',
                      'libXt.i686', 'libXtst.i686', 'libXxf86vm.i686', 'libaio.i686',
                      'libdrm.i686', 'libpciaccess.i686', 'libgcc.i686', 'libgfortran.i686',
                      'libidn.i686', 'libjpeg-turbo.i686', 'libpng.i686', 'libselinux.i686',
                      'libsepol.i686', 'libstdc++.i686', 'libtiff.i686', 'libuuid.i686',
                      'libxcb.i686', 'libxml2.i686', 'libxml2-devel.i686',
                      'mesa-dri-drivers.i686', 'mesa-dri-filesystem.i686', 'mesa-libGL.i686',
                      'mesa-libGLU.i686', 'ncurses-libs.i686', 'nspr.i686', 'nss.i686',
                      'nss-softokn.i686', 'nss-util.i686', 'openldap.i686', 'openmotif.i686',
                      'openmotif22.i686', 'openssl.i686', 'openssl098e.i686', 'pam.i686',
                      'readline.i686', 'sqlite.i686', 'tcl.i686', 'tk.i686', 'zlib.i686',
                      'compat-expat1.i686', 'compat-libgfortran-41.i686', 'freetype-devel.i686',
                      'libXext-devel.i686', 'libpng-devel.i686', 'mesa-libGL-devel.i686',
                      'mesa-libGLU-devel.i686', 'ncurses-devel.i686', 'libX11-devel.i686',
                      'libXau-devel.i686', 'libXdamage-devel.i686', 'libXdmcp-devel.i686',
                      'libXfixes-devel.i686', 'libXxf86vm-devel.i686', 'libdrm-devel.i686',
                      'libxcb-devel.i686', 'libtool-ltdl.i686', 'bzip2-devel.i686',
                      'libuuid-devel.i686',
                      'alsa-lib.x86_64', 'audit-libs.x86_64', 'bzip2-libs.x86_64',
                      'compat-db.x86_64', 'compat-db42.x86_64', 'compat-db43.x86_64',
                      'compat-libf2c-34.x86_64', 'compat-libstdc++-33.x86_64',
                      'compat-libtermcap.x86_64', 'compat-openldap.x86_64',
                      'compat-readline5.x86_64', 'cracklib.x86_64', 'cyrus-sasl-lib.x86_64',
                      'db4.x86_64', 'e2fsprogs-libs.x86_64', 'expat.x86_64',
                      'fontconfig.x86_64', 'freetype.x86_64', 'gamin.x86_64', 'gdbm.x86_64',
                      'giflib.x86_64', 'glib2.x86_64', 'glibc.x86_64', 'glibc-devel.x86_64',
                      'gmp.x86_64', 'keyutils-libs.x86_64', 'krb5-libs.x86_64', 'libICE.x86_64',
                      'libSM.x86_64', 'libX11.x86_64', 'libXau.x86_64', 'libXcursor.x86_64',
                      'libXdamage.x86_64', 'libXdmcp.x86_64', 'libXext.x86_64', 'libXfixes.x86_64',
                      'libXft.x86_64', 'libXi.x86_64', 'libXinerama.x86_64', 'libXmu.x86_64',
                      'libXp.x86_64', 'libXpm.x86_64', 'libXrandr.x86_64', 'libXrender.x86_64',
                      'libXt.x86_64', 'libXtst.x86_64', 'libXxf86vm.x86_64', 'libaio.x86_64',
                      'libdrm.x86_64', 'libpciaccess.x86_64', 'libgcc.x86_64', 'libgfortran.x86_64',
                      'libidn.x86_64', 'libjpeg-turbo.x86_64', 'libpng.x86_64', 'libselinux.x86_64',
                      'libsepol.x86_64', 'libstdc++.x86_64', 'libtiff.x86_64', 'libuuid.x86_64',
                      'libxcb.x86_64', 'libxml2.x86_64', 'libxml2-devel.x86_64',
                      'mesa-dri-drivers.x86_64', 'mesa-dri-filesystem.x86_64', 'mesa-libGL.x86_64',
                      'mesa-libGLU.x86_64', 'ncurses-libs.x86_64', 'nspr.x86_64', 'nss.x86_64',
                      'nss-softokn.x86_64', 'nss-util.x86_64', 'openldap.x86_64', 'openmotif.x86_64',
                      'openmotif22.x86_64', 'openssl.x86_64', 'openssl098e.x86_64', 'pam.x86_64',
                      'readline.x86_64', 'sqlite.x86_64', 'tcl.x86_64', 'tk.x86_64', 'zlib.x86_64',
                      'compat-expat1.x86_64', 'compat-libgfortran-41.x86_64', 'freetype-devel.x86_64',
                      'libXext-devel.x86_64', 'libpng-devel.x86_64', 'mesa-libGL-devel.x86_64',
                      'mesa-libGLU-devel.x86_64', 'ncurses-devel.x86_64', 'libX11-devel.x86_64',
                      'libXau-devel.x86_64', 'libXdamage-devel.x86_64', 'libXdmcp-devel.x86_64',
                      'libXfixes-devel.x86_64', 'libXxf86vm-devel.x86_64', 'libdrm-devel.x86_64',
                      'libxcb-devel.x86_64', 'libtool-ltdl.x86_64', 'bzip2-devel.x86_64',
                      'libuuid-devel.x86_64'
                    ]

    package {
      $base_packages:
        ensure => present,
    }
    package {
      $ml_packages:
        ensure => present,
    }
   
  } else
  {
    err("No WLCG package support for this arch!")
  }
}

