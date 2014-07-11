# Kibana3 nginx setup
class kibana3::nginx {

  class {'::nginx': }

  nginx::resource::vhost { $::hostname:
    ensure   => present,
    www_root => "/usr/src/${kibana3::archive}",
    require  => Archive[$kibana3::archive]
  }
}
