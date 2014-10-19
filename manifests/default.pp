include rvm

rvm_system_ruby {
  'ruby-1.8.7':
    ensure      => 'present',
    default_use => true;
}

package {'unzip':
  ensure => present,
}

exec { 'io-lang-debian-package':
  command => '/usr/bin/unzip /vagrant/iobin-linux-x64-deb-current.zip',
  cwd     => '/home/vagrant/',
  require => Package['unzip'],
}

package { 'io-lang':
  ensure   => present,
  provider => dpkg,
  source   => '/home/vagrant/IoLanguage-2013.11.04-Linux-x64.deb',
  require  => Exec['io-lang-debian-package'],
}
