class rte
{
  # Just copy the RTE files
  file {
    '/srv':
      ensure => directory,
  }
  file {
    '/srv/rte':
      ensure => directory,
      require => File['/srv'],
  }
  file {
    '/srv/rte/ENV':
      ensure => directory,
      require => File['/srv/rte'],
  }
  file {
    '/srv/rte/ENV/GLITE':
      ensure => present,
      mode => 755,
      source => 'puppet:///modules/rte/GLITE',
      require => File['/srv/rte/ENV'],
  }
  file {
    '/srv/rte/ENV/PROXY':
      ensure => present,
      mode => 755,
      source => 'puppet:///modules/rte/PROXY',
      require => File['/srv/rte/ENV'],
  }
}

