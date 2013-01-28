define jboss::service  (
  $basedir,
  $logdir,
  $product,
  $user,
  $group        = undef,
  $version      = undef,
  $java_home    = '/usr/java/latest',
  $java_opts    = '',
  $bind_address = $::fqdn,
  $config_file  = 'standalone.xml',
) {
  runit::service { "${user}-${product}":
    service     => $product,
    basedir     => $basedir,
    logdir      => $logdir,
    user        => $user,
    group       => $group,
    down        => true,
    timestamp   => false,
  }
  file { "${basedir}/runit/${product}/run":
    ensure  => present,
    mode    => '0555',
    owner   => $user,
    group   => $group,
    content => template("jboss/${product}/run.erb"),
    require => File["${basedir}/runit/${product}"],
  }
  file { "${basedir}/service/${product}":
    ensure  => link,
    target  => "${basedir}/runit/${product}",
    owner   => $user,
    group   => $group,
    replace => false,
    require => File["${basedir}/runit/${product}/run"], 
  }
}
