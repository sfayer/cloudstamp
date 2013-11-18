class rte($site_name = 'UNKNOWN',
          $close_se = 'NONE',
          $top_bdii = 'NONE')
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
      content => template('rte/GLITE.erb'),
      require => File['/srv/rte/ENV'],
  }
  file {
    '/srv/rte/ENV/PROXY':
      ensure => present,
      mode => 755,
      content => template('rte/PROXY.erb'),
      require => File['/srv/rte/ENV'],
  }
}

