define jboss::sunrmi (
  $install_dir,
  $user,
  $group,
) {
  $module = 'sunrmi'
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
}
