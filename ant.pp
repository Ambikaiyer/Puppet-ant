class ant (
  $version     = '1.9.4',
  $install_dir = '/opt',
) {

  $apache_dir = "${install_dir}/apache-ant-${version}"

  installer::extracted_artifact { "apache-ant-${version}-bin.tar.gz":
    path       => "com/apache/ant/${version}",
    target_dir => $install_dir,
    creates    => $apache_dir,
  }

  file { $apache_dir:
    mode => '0755',
  }

  file { "${install_dir}/ant":
    ensure => link,
    target => "apache-ant-${version}",
  }

  file { '/etc/profile.d/apache-ant.sh':
    content => "PATH=\$PATH:${install_dir}/ant/bin\n",
  }

  Installer::Extracted_artifact["apache-ant-${version}-bin.tar.gz"]
  -> File[$apache_dir]
  -> File["${install_dir}/ant"]
  -> File['/etc/profile.d/apache-ant.sh']

}
