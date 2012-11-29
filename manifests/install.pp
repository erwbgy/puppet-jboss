define jboss::install (
  $version,
  $user,
  $group,
  $basedir,
) {
  $zipfile = "${version}.zip"
  $subdir  = $version
  if ! defined(Package['unzip']) {
    package { 'unzip': ensure => installed }
  }
  if ! defined(Package['rsync']) {
    package { 'rsync': ensure => installed }
  }
  if ! defined(Package['sed']) {
    package { 'sed': ensure => installed }
  }
  # defaults
  File {
    owner => $user,
    group => $group,
  }
  file { "jboss-zipfile-${version}":
    ensure  => present,
    path    => "/root/jboss/${zipfile}",
    mode    => '0444',
    source  => "puppet:///files/${zipfile}",
    require => File['/root/jboss'],
  }
  exec { "jboss-unpack-${version}":
    cwd     => $basedir,
    command => "/usr/bin/unzip '/root/jboss/${zipfile}'",
    creates => "${basedir}/${subdir}",
    notify  => Exec["jboss-fix-ownership-${version}"],
    require => File["jboss-zipfile-${version}"],
  }
  file { "${basedir}/${subdir}":
    ensure  => directory,
    require => Exec["jboss-unpack-${version}"],
  }
  exec { "jboss-fix-ownership-${version}":
    command     => "/bin/chown -R ${user}:${group} ${basedir}/${subdir}",
    refreshonly => true,
  }
}
