define jboss::sunrmi (
  $install_dir,
  $user,
  $group,
) {
  $dir    = "${install_dir}/modules/sun/jdk/main"
  # Use XSLT to add the sun/rmi/server line:

#<module xmlns="urn:jboss:module:1.1" name="sun.jdk">
#    <resources>
#        <resource-root path="service-loader-resources"/>
#    </resources>
#    <dependencies>
#        <system export="true">
#            <paths>
#                <path name="com/sun/script/javascript"/>
#                ...
#                <path name="sun/rmi/server"/>
#                ...
#                <path name="META-INF/services"/>
#            </paths>
  $module = 'sunjdk'
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
}
