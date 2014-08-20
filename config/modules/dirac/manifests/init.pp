class dirac($dirac_setup   = 'Unknown',
            $dirac_release = 'v6r11p1',
            $dirac_cs      = 'None',
            $dirac_ce      = 'None',
            $dirac_site    = 'None',
            $dirac_pool    = 'None')
{
  # Create a user for dirac
  user {
    'dirac':
      ensure => present,
      home => '/home/dirac',
      managehome => true,
      password => '*LK*',
  }
  # Install the hostcert/key
  file {
    '/etc/grid-security':
      ensure => directory,
      owner => root,
      group => root,
      mode => 755,
  }
  file {
    '/etc/grid-security/hostcert.pem':
      ensure => present,
      owner => dirac,
      group => dirac,
      mode => 600,
      source => 'puppet:///modules/dirac/hostcert.pem',
      require => [ File['/etc/grid-security'],
                   User['dirac'] ]
  }
  file {
    '/etc/grid-security/hostkey.pem':
      ensure => present,
      owner => dirac,
      group => dirac,
      mode => 600,
      source => 'puppet:///modules/dirac/hostkey.pem',
      require => [ File['/etc/grid-security'],
                   User['dirac'] ]
  }
  # Install the dirac-pilot/install/startup scripts
  file {
    '/home/dirac/dirac-install.py':
      ensure => present,
      owner => dirac,
      group => dirac,
      mode => 755,
      source => 'puppet:///modules/dirac/dirac-install.py',
      require => User['dirac'],
  }
  file {
    '/home/dirac/dirac-pilot.py':
      ensure => present,
      owner => dirac,
      group => dirac,
      mode => 755,
      source => 'puppet:///modules/dirac/dirac-pilot.py',
      require => User['dirac'],
  }
  # Drop the dirac-startup script as /etc/rc.local.
  file {
    '/etc/rc.d/rc.local':
      ensure => present,
      owner => root,
      group => root,
      mode => 755,
      content => template('dirac/dirac-startup.sh.erb'),
      require => User['dirac'],
  }
}

