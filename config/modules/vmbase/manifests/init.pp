
class vmbase($msg = 'CloudStamp Image')
{
  # Erase the persistent network state
  file {
    '/etc/udev/rules.d/70-persistent-net.rules':
      ensure => absent,
  }
  file {
    '/etc/sysconfig/network-scripts/ifcfg-eth0':
      ensure => present,
      source => 'puppet:///modules/vmbase/ifcfg-eth0',
  }

  # Turn off the SSH root login just to be sure
  augeas {
    'disable_root':
      context => '/files/etc/ssh/sshd_config',
      changes => 'set PermitRootLogin without-password',
  }

  # Write the banners
  file {
    '/etc/issue':
      ensure => present,
      content => "\n$msg\n\n",
  }
  file {
    '/etc/motd':
      ensure => present,
      content => "\n$msg\n\n",
  }
}

