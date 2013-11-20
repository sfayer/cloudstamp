class glexec
{
  # Install the packages
  package {
    'glexec':
      ensure => present,
      require => Package['emi-wn'],
  }
  package {
    'lcmaps-plugins-basic':
      ensure => present,
      require => Package['glexec'],
  }
  package {
    'lcmaps-plugins-verify-proxy':
      ensure => present,
      require => Package['lcmaps-plugins-basic'],
  }
  # Create the config files
  file {
    '/etc/glexec.conf':
      ensure => present,
      mode => 640,
      owner => 'root',
      group => 'glexec',
      source => 'puppet:///modules/glexec/glexec.conf',
      require => Package['lcmaps-plugins-verify-proxy'],
  }
  # /etc/grid-security should have been made in the WN install
  # Create the grid-mapfile and gridmapdir in them
  file {
    '/etc/grid-security/grid-mapfile':
      ensure => present,
      source => 'puppet:///modules/glexec/grid-mapfile',
      require => File['/etc/glexec.conf'],
  }
  file {
    '/etc/grid-security/gridmapdir':
      ensure => directory,
      require => File['/etc/glexec.conf'],
  }
  # Now configure lcmaps...
  file {
    '/etc/lcmaps':
      ensure => directory,
      require => Package['lcmaps-plugins-verify-proxy'],
  }
  file {
    '/etc/lcmaps/lcmaps-glexec.db':
      ensure => present,
      mode => 640,
      source => 'puppet:///modules/glexec/lcmaps-glexec.db',
      require => File['/etc/lcmaps'],
  }
  # Create the pool users
  define pool_user($uname = $title) {
    user {
      "${uname}":
        ensure => present,
        home => "/home/${uname}",
        managehome => true,
        password => '*LK*',
        require => File['/etc/grid-security/gridmapdir'],
    }
    file {
      "/etc/grid-security/gridmapdir/${uname}":
        ensure => present,
        require => User["${uname}"],
    }
  }
  # Ordering isn't required but it's nice to have sorted names
  pool_user { 'pool0': }
  pool_user { 'pool1': require => User["pool0"] }
  pool_user { 'pool2': require => User["pool1"] }
  pool_user { 'pool3': require => User["pool2"] }
  pool_user { 'pool4': require => User["pool3"] }
  pool_user { 'pool5': require => User["pool4"] }
  pool_user { 'pool6': require => User["pool5"] }
  pool_user { 'pool7': require => User["pool6"] }
  pool_user { 'pool8': require => User["pool7"] }
  pool_user { 'pool9': require => User["pool8"] }
  pool_user { 'pool10': require => User["pool9"] }
  pool_user { 'pool11': require => User["pool10"] }
  pool_user { 'pool12': require => User["pool11"] }
  pool_user { 'pool13': require => User["pool12"] }
  pool_user { 'pool14': require => User["pool13"] }
  pool_user { 'pool15': require => User["pool14"] }
  pool_user { 'pool16': require => User["pool15"] }
  pool_user { 'pool17': require => User["pool16"] }
  pool_user { 'pool18': require => User["pool17"] }
  pool_user { 'pool19': require => User["pool18"] }

}

