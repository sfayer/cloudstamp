
class glidein
{
   # Drop the RPM files
   file {
    '/root/glideinwms-vm-core.rpm':
      ensure => present,
      source => 'puppet:///modules/glidein/glideinwms-vm-core-0.4-0.2.rc2.tmp.el6.noarch.rpm',
   } 
   file {
    '/root/glideinwms-vm-ec2.rpm':
      ensure => present,
      source => 'puppet:///modules/glidein/glideinwms-vm-ec2-0.4-0.2.rc2.tmp.el6.noarch.rpm',
   } 
   # Install the RPMs
   package {
    'glideinwms-vm-core':
      provider => 'rpm',
      ensure => present,
      source => '/root/glideinwms-vm-core.rpm',
      require => File['/root/glideinwms-vm-core.rpm'],
   }
   package {
    'glideinwms-vm-ec2':
      provider => 'rpm',
      ensure => present,
      source => '/root/glideinwms-vm-ec2.rpm',
      require => [ File['/root/glideinwms-vm-ec2.rpm'],
                   Package['glideinwms-vm-core']],
   }
   # glideinWMS expects to run sudo without a terminal
   # augeas didn't work for some reason... use file instead
   #augeas {
   # 'sudo_notty':
   #   context => '/files/etc/sudoers',
   #   changes => 'clear /Defaults/requiretty/negate',
   #   require => Package['glideinwms-vm-core'],
   #}
   file {
     '/etc/sudoers':
       ensure => present,
       owner => 'root',
       group => 'root',
       mode => 440,
       source => 'puppet:///modules/glidein/sudoers',
       require => Package['glideinwms-vm-core'],
   }
}

