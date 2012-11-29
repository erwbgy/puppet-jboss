class jboss::config {
  # TODO: Find recommended values - these are for WSO2
  augeas { 'jboss-sysctl':
    context => '/files/etc/sysctl.conf',
    changes => [
      'set net.ipv4.tcp_fin_timeout 30',
      'set fs.file-max 2097152',
      'set net.ipv4.tcp_tw_recycle 1',
      'set net.ipv4.tcp_tw_reuse 1',
      'set net.core.rmem_default 524288',
      'set net.core.wmem_default 524288',
      'set net.core.rmem_max 67108864',
      'set net.core.wmem_max 67108864',
      'set net.ipv4.tcp_rmem 4096 87380 16777216',
      'set net.ipv4.tcp_wmem 4096 65536 16777216',
    ],
  }
  limits::set { '@jboss':
    item   => 'nofile',
    soft   => '4096',
    hard   => '65535'
  }
}
