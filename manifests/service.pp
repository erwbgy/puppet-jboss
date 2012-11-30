define jboss::service  (
  $product      = undef,
  $user         = undef,
  $group        = undef,
  $version      = undef,
  $java_home    = '/usr/java/latest',
  $java_opts    = '',
  $home         = '/home',
  $bind_address = $::fqdn,
  $config_file  = 'standalone.xml',
) {
  runit::service { "${user}-${product}":
    service     => $product,
    user        => $user,
    group       => $group,
    down        => true,
  }
  file { "${home}/${user}/runit/${product}/run":
    ensure  => present,
    mode    => '0555',
    owner   => $user,
    group   => $group,
    content => template("jboss/${product}/run.erb"),
    require => File["${home}/${user}/runit/${product}"],
  }
  file { "${home}/${user}/service/${product}":
    ensure  => link,
    target  => "${home}/${user}/runit/${product}",
    owner   => $user,
    group   => $group,
    replace => false,
    require => File["${home}/${user}/runit/${product}/run"],
  }
  file { "${home}/${user}/logs/${product}":
    ensure  => directory,
    owner   => $user,
    group   => $group,
  }
  file { "${home}/${user}/logs/${product}/repository":
    ensure  => link,
    owner   => $user,
    target  => "${home}/${user}/${product}-${version}/repository/logs",
    require => File["${home}/${user}/logs/${product}"],
  }
  file { "${home}/${user}/${product}":
    ensure  => link,
    owner   => $user,
    target  => "${home}/${user}/${product}-${version}",
    require => File["${home}/${user}/${product}-${version}"],
  }
  file { "${home}/${user}/configuration":
    ensure  => directory,
    owner   => $user,
    require => User[$user],
  }
}
