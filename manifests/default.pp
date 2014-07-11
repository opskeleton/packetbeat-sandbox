group{ 'puppet': ensure  => present }

node 'packerbeat.local' {

  $archive = 'kibana-3.1.0-packetbeat'
  $url = 'https://github.com/packetbeat/kibana/releases/download/v3.1.0-pb'

  class{'kibana3':
    url     => "${url}/${archive}.tar.gz",
    archive => $archive,
    ext     => 'tar.gz'
  }

  include elasticsearch
  include packetbeat
}
