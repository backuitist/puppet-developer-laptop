class maven {
  
  include base::bin

  File {
    owner  => $real_id,
    group  => $real_id
  }

  $maven_version = '3.3.9'
  $maven_dir = "${home}/bin/apache-maven-${maven_version}"  
  $maven_dir_exists = "/usr/bin/test -d ${maven_dir}"
  $maven_tmp = "/tmp/apache-maven-${maven_version}.tgz"

  wget::fetch { "http://www.pirbot.com/mirrors/apache/maven/maven-3/${maven_version}/binaries/apache-maven-${maven_version}-bin.tar.gz":
    destination => $maven_tmp,
    unless      => $maven_dir_exists
  }
  ->
  exec { "/bin/tar xzf ${maven_tmp} -C ${home}/bin":
    unless => $maven_dir_exists,
    user   => $real_id,
    group  => $real_id
  }
  ->
  file { "${home}/bin/maven-current":
    ensure => 'link',
    target => $maven_dir
  }
  ->
  file { "${home}/bin/mvn":
    ensure => 'link',
    target => "${home}/bin/maven-current/bin/mvn"
  }
  ->
  file { "${home}/bin/mvnDebug":
    ensure => 'link',
    target => "${home}/bin/maven-current/bin/mvnDebug"
  }
}
