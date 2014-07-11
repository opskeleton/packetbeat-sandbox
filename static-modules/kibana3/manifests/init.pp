# Sets up a kibana3 instance
class kibana3(
  $url = 'https://download.elasticsearch.org/kibana/kibana/kibana-3.0.1.zip',
  $archive = 'kibana-3.0.1',
  $ext = 'zip'
) {

  notice($url)
  include kibana3::nginx
  include kibana3::logstash


  package{['curl','unzip']:
    ensure  => present
  }

  Exec {
    path => ['/usr/bin/', '/bin']
  }

  archive { $archive:
    ensure           => present,
    digest_string    => 'cee7b65bc9e950d1d867c8f64776d8f3',
    url              => $url,
    target           => '/usr/src',
    allow_insecure   => true,
    extension        => $ext,
    require          => [Package['curl'],Package['unzip']],
    follow_redirects => true
  }
}
