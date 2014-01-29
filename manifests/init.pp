# Class to install and configure deluge daemon
class deluge(
    $user         = $deluge::params::user,
    $group        = $deluge::params::group,
    $package_name = $deluge::params::package_name,
    $service_name = $deluge::params::service_name,
    $homedir      = $deluge::params::homedir

) inherits deluge::params{

    package{$package_name:
      ensure => present;
    }->
    group {$group:
      ensure => present,
      system => true;
    }->
    user {$user:
      ensure     => present,
      home       => '/var/lib/deluge',
      managehome => true,
      system     => true,
      gid        => $group,
      require    => Group[$group];
    }->
    file {
      "/etc/init/${service_name}.conf":
        ensure  => file,
        mode    => '0644',
        owner   => root,
        group   => root,
        content => template('deluge/deluged.conf.erb');
      '/var/log/deluge':
        ensure => directory,
        mode   => 0750,
        owner  => $user,
        group  => $group;
    }~>
    service {$service_name:
      ensure    => running,
      provider  => upstart,
    }


}

