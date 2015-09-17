# vagrant/puppet/modules/mysql/manifests/init.pp
class mysql {

  # Install mysql
  package { ['mysql-server']:
    ensure => present,
    require => Exec['apt-get update'],
  }

  # Run mysql
  service { 'mysql':
    ensure  => running,
    require => Package['mysql-server'],
  }

  # Use a custom mysql configuration file
  file { '/etc/mysql/my.cnf':
    source  => 'puppet:///modules/mysql/my.cnf',
    require => Package['mysql-server'],
    owner   => 'root',
    group   => 'root',
    mode    => 'u+rwx',
    notify  => Service['mysql'],
  }

  exec { 'set-mysql-password':
    command => "mysql -u root -ps3cret -e 'SELECT CURDATE();' || mysqladmin -u root password s3cret",
    path    => ['/bin', '/usr/bin'],
    require => Service['mysql'];
  }

  exec { 'create-database':
    command => "mysql -u root -ps3cret -e 'SELECT CURDATE();' || mysql -uroot -ps3cret -e \"create database db; grant all on db.* to root@localhost identified by 's3cret';\"",
    path    => ['/bin', '/usr/bin'],
    require => Exec['set-mysql-password'];
  }
  exec { 'load-dynamic-sql':
    command => "mysql -u root -ps3cret -e 'SELECT CURDATE();' || mysql -u root -ps3cret db < /vagrant/puppet/modules/mysql/files/db.sql",
    path    => ['/bin', '/usr/bin'],
    require => Exec['create-database'];
  }
}