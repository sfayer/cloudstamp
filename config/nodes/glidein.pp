# glideinwms.pp: A basic image for glideinWMS

class {
  'vmbase':
    msg => "CloudStamp glideinWMS Image",
}

class {
  'cvmfs':
    squid_list => 'http://lt2cache00.grid.hep.ph.ic.ac.uk:3128',
}

include ssh_keys
include glidein
include wlcg
include wn_install
include glexec

