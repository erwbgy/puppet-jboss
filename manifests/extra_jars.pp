define jboss::extra_jars (
  $product_dir,
  $destination,
  $user,
  $group = 'jboss',
  $home  = '/home',
) {
  $jar_file = regsubst($title, "^${product_dir}/", '')
  file { "${destination}/${jar_file}":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => '0444',
    source  => "puppet:///files/${jar_file}",
    require => File[$product_dir],
  }
}
