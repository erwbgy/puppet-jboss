# puppet-jboss

Puppet module to install JBoss products and set them up to run as Runit services
under one or more users.

The recommended usage is to place the configuration is hiera and just:

    include jboss

Example hiera config:

    # JBoss Application Server
    jboss::as:
      jbossas1:
        extra_jars:
          - mysql-connector-java-5.1.21.jar
        group: jboss
        java_home: /usr/java/jdk1.7.0_07
        version: 7.1.1.Final
      jbossas2:
        extra_jars:
          - mysql-connector-java-5.1.21.jar
        java_home: /usr/java/jdk1.6.0_37
        version: 4.5.0
    
    # HornetQ
    jboss::hornetq:
      hornetq1:
        group: jboss
        java_home: /usr/java/jdk1.7.0_07
        version: 2.2.14

## Parameters

All product classes take following parameters:

*title*: The user the product runs as

*bind_address*: The IP address listen sockets are bound to. Default: $::fqdn

*extra_jars*: Additional jar files to be placed in the repository/component/lib directory

*group*: The user's primary group. Default: 'jboss',

*home*: The parent directory of user home directories Default: '/home',

*java_home*: The base directory of the JDK installation to be used. Default: '/usr/java/latest',

*java_opts*: Additional java command-line options to pass to the startup script

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
