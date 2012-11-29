class jboss {
  include '::jboss::config'

  file { '/root/jboss':
    ensure => directory,
    owner  => 'root',
    group  => 'jboss',
    mode   => '0750',
  }

  # Application Server
  $as = hiera_hash('jboss::as', undef)
  if $as {
    create_resources('jboss::as', $as)
  }

  # HornetQ
  $hornetq = hiera_hash('jboss::hornetq', undef)
  if $hornetq {
    create_resources('jboss::hornetq', $hornetq)
  }
}
