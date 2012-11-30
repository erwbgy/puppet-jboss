define jboss::as (
  $bind_address = $::fqdn,
  $config_file  = 'standalone.xml',
  $extra_jars   = [],
  $group        = 'jboss',
  $home         = '/home',
  $java_home    = '/usr/java/latest',
  $java_opts    = '',
  $version      = undef,
  $ojdbc6       = false,
  $coherence    = false,
  $sunrmi       = false,
) {
  $user        = $title
  $product     = 'jboss-as'
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

  if $ojdbc6 {
    jboss::modules::ojdbc6 { "${user}-${product}":
      install_dir => "${home}/${user}/${product}-${version}",
      user        => $user,
      group       => $group,
    }
  }

  if $coherence {
    jboss::modules::coherence { "${user}-${product}":
      install_dir => "${home}/${user}/${product}-${version}",
      user        => $user,
      group       => $group,
    }
  }

  if $sunrmi {
    jboss::modules::sunrmi { "${user}-${product}":
      install_dir => "${home}/${user}/${product}-${version}",
      user        => $user,
      group       => $group,
    }
  }

  $file_paths = prefix($extra_jars, "${product_dir}/")
  jboss::extra_jars { $file_paths:
    product_dir => $product_dir,
    destination => "${product_dir}/standalone/lib/ext",
    user        => $user,
    require     => File[$product_dir],
  }

  jboss::service{ "${user}-${product}":
    product      => $product,
    user         => $user,
    group        => $group,
    version      => $version,
    java_home    => $java_home,
    java_opts    => $java_opts,
    home         => $home,
    bind_address => $bind_address,
    config_file  => $config_file,
  }
}
