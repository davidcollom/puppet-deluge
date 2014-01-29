class deluge::logrotate{

  if defined('logrotate::rule') {

    logrotate::rule { 'deluge':
      path          => '/var/log/deluge/daemon.log',
      rotate        => 4,
      rotate_every  => week,
      sharedscripts => true,
      missingok     => true,
      delaycompress => true,
      ifempty       => false,
      compress      => true,
      postrotate    => "initctl restart ${deluged::service_name};";
    }
    if defined(Class['deluged::web'])
    {
      logrotate::rule { 'deluged::web::web_service_name':
        path          => '/var/log/deluge/web.log',
        rotate        => 4,
        rotate_every  => week,
        sharedscripts => true,
        missingok     => true,
        delaycompress => true,
        ifempty       => false,
        compress      => true,
        postrotate    => "initctl restart ${deluged::web::web_service_name};";
      }
    }
  }

}