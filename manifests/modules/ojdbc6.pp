define jboss::ojdbc6 (
  $install_dir,
  $user,
  $group,
) {
  $module = 'ojdbc6'
  $dir    = "${install_dir}/modules/com/oracle/ojdbc6/main"
  exec { "mkdir-${module}-${version}":
    command => "/bin/mkdir -p ${dir}",
    require => File[$install_dir],
  }
  file { "${dir}":
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
  file { "${dir}/ojdbc6.jar":
    ensure  => present,
    owner   => $user,
    group   => $group,
    source  => "puppet:///files/ojdbc6.jar",
    require => File[$dir],
  }
}
