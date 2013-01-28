define jboss::as (
  $version,
  $basedir      = '/opt/jboss',
  $bind_address = $::fqdn,
  $config_file  = 'standalone.xml',
  $extra_jars   = [],
  $group        = 'jboss',
  $java_home    = '/usr/java/latest',
  $java_opts    = '',
  $logdir       = '/var/log/jboss',
  $ojdbc6       = false,
  $coherence    = false,
  $sunjdk       = false,
) {
  $user        = $title
  $product     = 'jboss-as'
  $product_dir = "${basedir}/product/${product}-${version}"

  include runit
  if ! defined(File["${basedir}/runit/${user}"]) {
    runit::user { $user:
      basedir => $basedir,
      group   => $group,
    }
  }

  jboss::install { "${user}-${product}":
    version     => "${product}-${version}",
    user        => $user,
    group       => $group,
    basedir     => $basedir,
  }

  if $ojdbc6 {
    jboss::modules::ojdbc6 { "${user}-${product}":
      install_dir => $product_dir,
      user        => $user,
      group       => $group,
    }
  }

  if $coherence {
    jboss::modules::coherence { "${user}-${product}":
      install_dir => $product_dir,
      user        => $user,
      group       => $group,
    }
  }

  if $sunjdk {
    jboss::modules::sunjdk { "${user}-${product}":
      install_dir => $product_dir,
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
    basedir      => $basedir,
    logdir       => $logdir,
    product      => $product,
    user         => $user,
    group        => $group,
    version      => $version,
    java_home    => $java_home,
    java_opts    => $java_opts,
    bind_address => $bind_address,
    config_file  => $config_file,
  }
}
