define jboss::coherence (
  $install_dir,
  $user,
  $group,
) {
  $module = 'coherence'
  $dir    = "${install_dir}/modules/com/oracle/coherence/main"
  exec { "mkdir-${module}-${version}":
    command => "/bin/mkdir -p ${dir}",
    require => File[$install_dir],
  }
  file { $dir:
    ensure  => directory,
    owner   => $user,
    group   => $group,
    require => Exec["mkdir-${module}-${version}"],
  }
  file { "${dir}/module.xml":
    ensure  => present,
    owner   => $user,
    group   => $group,
    content => template("jboss/jboss-as/modules/${module}-module.xml"),
    require => File[$dir],
  }
  file { "${dir}/coherence.jar":
    ensure  => present,
    owner   => $user,
    group   => $group,
    source  => "puppet:///files/coherence.jar",
    require => File[$dir],
  }
}
