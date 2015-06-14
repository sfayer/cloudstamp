
class wlcg
{
  # WLCG repository is now signed, so use the HEP_OSlibs meta-package
  # 
  # 
  if $architecture == 'x86_64'
  {

     file {
      '/etc/pki/rpm-gpg/RPM-GPG-KEY-wlcg':
        ensure => present,
        source => 'puppet:///modules/wlcg/RPM-GPG-KEY-wlcg',
     }
     yumrepo {
      'WLCG':
        descr => 'WLCG Repository',
        baseurl => 'http://linuxsoft.cern.ch/wlcg/sl6/x86_64',
        gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-wlcg',
        gpgcheck => 1,
        enabled => 1,
        protect => 1,
        require => File['/etc/pki/rpm-gpg/RPM-GPG-KEY-wlcg'],
  }

    package {
      'HEP_OSlibs_SL6':
        ensure => present,
        require => Yumrepo['WLCG'],
    }
   
  } else
  {
    err("No WLCG package support for this arch!")
  }
}

