class deluge::web(
  $port           =  $deluge::params::web_port,
  $web_service_name   =  $deluge::params::web_service_name
) inherits deluge
{
  package{'deluge-web':
    ensure  => present;
  }

  file{"/etc/init/${web_service_name}.conf":
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    content => template('deluge/deluge-web.conf.erb');
  }

  service{$web_service_name:
    ensure      => running,
    provider    => upstart,
    subscribe   => File["/etc/init/${web_service_name}.conf"];
  }

}