# Setting up logstash for streaming data into Kibana
class kibana3::logstash {
  include elasticsearch::repo

  Apt::Key['elasticsearch-key'] ->

  apt::source { 'elasticsearch-logstash':
    location    => 'http://packages.elasticsearch.org/logstash/1.3/debian',
    release     => 'stable',
    repos       => 'main',
    include_src => false,
  } ->

  class { '::logstash':
    init_defaults_file => 'puppet:///modules/kibana3/logstash'
  }

  logstash::configfile { 'elastic_output':
    source => 'puppet:///modules/kibana3/elastic_output',
    order  => 10
  }

  logstash::configfile { 'gelf_input':
    source => 'puppet:///modules/kibana3/gelf_input',
    order  => 10
  }

}
