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
    source  => "puppet:///files/jboss/${zipfile}",
    require => File['/root/jboss'],
  }
  if ! defined(File["${basedir}/product"]) {
    file { "${basedir}/product":
      ensure => directory,
      mode   => '0750',
    }
  }
  exec { "jboss-unpack-${version}":
    cwd     => "${basedir}/product",
    command => "/usr/bin/unzip '/root/jboss/${zipfile}'",
    creates => "${basedir}/product/${subdir}",
    notify  => Exec["jboss-fix-ownership-${version}"],
    require => File["jboss-zipfile-${version}", "${basedir}/product"],
  }
  file { "${basedir}/product/${subdir}":
    ensure  => directory,
    require => Exec["jboss-unpack-${version}"],
  }
  exec { "jboss-fix-ownership-${version}":
    command     => "/bin/chown -R ${user}:${group} ${basedir}/product/${subdir}",
    refreshonly => true,
  }
}
