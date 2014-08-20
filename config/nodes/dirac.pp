# dirac.pp: A basic image for dirac

class {
  'vmbase':
    msg => "CloudStamp DIRAC Image",
}

class {
  'cvmfs':
    squid_list => 'auto;DIRECT',
    cms_site => 'T2_UK_London_IC',
}

class {
  'wn_install':
    site_name => 'UKI-LT2-IC-HEP',
    close_se => 'gfe02.grid.hep.ph.ic.ac.uk',
    top_bdii => 'localbdii.grid.hep.ph.ic.ac.uk:2170',
}

class {
  'dirac':
    dirac_setup => 'Stealth-Production',
    dirac_release => 'v6r11p1',
    dirac_cs => 'dips://dwms00.grid.hep.ph.ic.ac.uk:9135/Configuration/Server',
    dirac_ce => 'cloud.imperial.ac.uk',
    dirac_site => 'CLOUD.gridpp.ac.uk',
    dirac_pool => 'CloudPool',
}

include ssh_keys
include wlcg
include glexec
include rte

