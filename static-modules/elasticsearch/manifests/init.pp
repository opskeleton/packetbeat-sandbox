# A modern elasticsearch module
class elasticsearch {

  include apt
  include elasticsearch::repo

  package{'openjdk-7-jre':
    ensure  => present
  }

  package{'elasticsearch':
    ensure  => present,
    require => Apt::Source['elasticsearch']
  }

  file_line {'elasticsearch heap size':
    path    => '/etc/init.d/elasticsearch',
    match   => 'ES_HEAP_SIZE=',
    line    => 'ES_HEAP_SIZE=2g',
    require => Package['elasticsearch']
  } ~>

  service{'elasticsearch':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => [Package['elasticsearch'], Package['openjdk-7-jre']]
  }

}
