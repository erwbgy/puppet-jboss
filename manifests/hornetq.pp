define jboss::hornetq (
  $bind_address = $::fqdn,
  $extra_jars   = [],
  $group        = 'jboss',
  $home         = '/home',
  $java_home    = '/usr/java/latest',
  $java_opts    = '',
  $version      = undef,
) {
  $user        = $title
  $product     = 'hornetq'
  $product_dir = "${home}/${user}/${product}-${version}"

  if ! defined(File["/etc/runit/${user}"]) {
    runit::user { $user: group => $group }
  }

  jboss::install { "${user}-${product}":
    version     => "${product}-${version}",
    user        => $user,
    group       => $group,
    basedir     => "${home}/${user}",
  }

  $file_paths = prefix($extra_jars, "${product_dir}/")
  jboss::extra_jars { $file_paths:
    product_dir => $product_dir,
    destination => "${product_dir}/standalone/lib/ext",
    user        => $user,
    require     => File[$product_dir],
  }

  jboss::service{ "${user}-${product}":
    product   => $product,
    user      => $user,
    group     => $group,
    version   => $version,
    java_home => $java_home,
    java_opts => $java_opts,
    home      => $home,
  }
}
