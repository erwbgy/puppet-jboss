# _Unmaintained_

I no longer use Puppet actively and this software has not been maintained for some time.

# puppet-jboss

Puppet module to install JBoss products and set them up to run as Runit services
under one or more users.

The recommended usage is to place the configuration is hiera and just:

    include jboss

Example hiera config:

    # JBoss Application Server
    jboss::as:
      jbossas1:
        basedir:      '/apps/jbossas1'
        bind_address: %{ipaddress_eth0}
        group:        'jboss'
        java_home:    '/usr/java/jdk1.7.0_09'
        java_opts:    "-Xms1536m -Xmx1536m -XX:MaxPermSize=512m -Djboss.bind.address.management=%{ipaddress_eth0} -Djava.net.preferIPv4Stack=true"
        logdir:       '/apps/jbossas1/logs'
        version:      '7.1.1.Final'

## jboss::as parameters

All product classes take following parameters:

*title*: The user the product runs as

*basedir*: The base installation directory. Default: '/opt/jboss'

*bind_address*: The IP address listen sockets are bound to. Default: $::fqdn

*config_file*: The main server configuration file. Default: 'standalone.xml

*extra_jars*: Additional jar files to be placed in the repository/component/lib directory. Default: []

*group*: The user's primary group. Default: 'jboss'

*java_home*: The base directory of the JDK installation to be used. Default:
'/usr/java/latest'

*java_opts*: Additional java command-line options to pass to the startup
script. Default: ''

*logdir*: The base log directory. Default: '/var/logs/jboss'

*ojdbc6*: Install the Oracle JDBC driver and module configuration
*coherence*: Install the Coherence driver and module configuration
*sunjdk*: Install the Sun JDK module configuration

*version*: The version of the product to install (eg. 4.5.1). **Required**.

## Product zip files

Place the product zip files (eg. jboss-as-7.1.1.Final.zip) under the 'files' file store.  For example if /etc/puppet/fileserver.conf has:

    [files]
    path /var/lib/puppet/files

the put the zip files in /var/lib/puppet/files.

## Notes

Currently:

* Only the JBoss Application Server has been tested

## Support

License: Apache License, Version 2.0

GitHub URL: https://github.com/erwbgy/puppet-jboss
