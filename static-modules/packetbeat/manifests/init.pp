# setting up packetbeat agent see http://packetbeat.com/getstarted
class packetbeat {

  $version = '0.2.2'
  $url  = "https://github.com/packetbeat/packetbeat/releases/download/v${version}"

  $deb  = "packetbeat_${version}-1_amd64.deb"

  package{'libpcap0.8':
    ensure  => present
  } ->

  exec{'packetbeat-deb-download':
    command => "wget -P /tmp ${url}/${deb}",
    user    => 'root',
    path    => ['/usr/bin','/bin'],
    unless  => "dpkg -s packetbeat | grep ${version}"
  } ->

  exec{'packetbeat-deb-install':
    command => "dpkg -i /tmp/${deb}",
    user    => 'root',
    path    => ['/usr/bin','/bin','/usr/local/sbin', '/usr/sbin', '/sbin'],
    unless  => "dpkg -s packetbeat | grep ${version}"
  } ->

  file { '/etc/packetbeat/packetbeat.conf':
    ensure=> file,
    mode  => '0644',
    source=> 'puppet:///modules/packetbeat/packetbeat.conf',
    owner => root,
    group => root,
  }

  $template = '/etc/packetbeat/packetbeat.template.json'

  file {$template :
    ensure=> file,
    mode  => '0644',
    source=> 'puppet:///modules/packetbeat/packetbeat.template.json',
    owner => root,
    group => root,
  } ->

  exec{'PUT template':
    command => "curl -XPUT 'http://localhost:9200/_template/packetbeat' -d@${template}",
    user    => 'root',
    path    => ['/usr/bin','/bin',],
    require => [Service['elasticsearch'], Exec['packetbeat-deb-install']]
  }

}
