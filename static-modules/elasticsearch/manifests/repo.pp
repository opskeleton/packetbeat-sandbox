# elasticsearch repo setup
class elasticsearch::repo {
  apt::key { 'elasticsearch-key':
    key        => '60D31954',
    key_source => 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch',
  } ->

  apt::source { 'elasticsearch':
    location    => 'http://packages.elasticsearch.org/elasticsearch/1.1/debian',
    repos       => 'main',
    include_src => false,
    release     => 'stable'
  }

}
