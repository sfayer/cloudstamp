
class cvmfs($squid_list, $cms_site = 'NONE')
{
  # Copy the key
  file {
    '/etc/pki/rpm-gpg/RPM-GPG-KEY-CernVM':
      ensure => present,
      source => 'puppet:///modules/cvmfs/RPM-GPG-KEY-CernVM',
  }
  # Configure the standard CVMFS repo
  yumrepo {
    'cvmfs':
      descr => 'CernVM packages',
      baseurl => 'http://cvmrepo.web.cern.ch/cvmrepo/yum/cvmfs/EL/$releasever/$basearch/',
      gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CernVM',
      gpgcheck => 1,
      enabled => 1,
      protect => 1,
      require => File['/etc/pki/rpm-gpg/RPM-GPG-KEY-CernVM'],
  }
  # Set-up fuse
  package {
    'fuse':
      ensure => present,
  }
  file {
    '/etc/fuse.conf':
      ensure => present,
      require => Package['fuse'],
  }
  # Install the packages from the repo
  package {
    'cvmfs-keys':
      ensure => present,
      require => Yumrepo['cvmfs'],
  }
  package {
    'cvmfs':
      ensure => present,
      require => Package['cvmfs-keys'],
  }
  # Add the squid server to the config
  file {
    '/etc/cvmfs/default.local':
      ensure => present,
      content => "CVMFS_HTTP_PROXY=\"$squid_list\"\n",
      require => Package['cvmfs'],
  }
  # Also enable the gridpp repos
  file {
    '/etc/cvmfs/keys/gridpp.ac.uk.pub':
      ensure => present,
      source => 'puppet:///modules/cvmfs/gridpp.ac.uk.pub',
      require => Package['cvmfs'],
  }
  file {
    '/etc/cvmfs/domain.d/gridpp.ac.uk.conf':
      ensure => present,
      source => 'puppet:///modules/cvmfs/gridpp.ac.uk.conf',
      require => File['/etc/cvmfs/keys/gridpp.ac.uk.pub'],
  }
  # Overwrite auto.master with a CVMFS only one
  file {
    '/etc/auto.master':
      ensure => present,
      content => "/cvmfs /etc/auto.cvmfs\n",
      require => Package['cvmfs'],
  }
  # Create the CMS site config if needed
  if $cms_site != 'NONE' {
    file {
      '/etc/cvmfs/config.d/cms.cern.ch.local':
        ensure => present,
        content => "export CMS_LOCAL_SITE=$cms_site\n",
        require => Package['cvmfs'],
    }
    # The bit below is a hack for our grid site
    # It makes the CVMFS SITECONF accessible at the normal local path
    # SITECONF isn't flexible enough to use relative paths or env vars.
    file {
      [ '/vols', '/vols/sl5_exp_software', '/vols/sl5_exp_software/cms' ]:
        ensure => directory,
        require => Package['cvmfs'],
    }
    file {
      '/vols/sl5_exp_software/cms/SITECONF':
        ensure => link,
        target => '/cvmfs/cms.cern.ch/SITECONF',
        require => File['/vols/sl5_exp_software/cms'],
    }
  }
}

