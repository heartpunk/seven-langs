include rvm

Exec {
  path => ['/bin', '/usr/bin', '/usr/local/bin']
}

# RVM just added a GPG key check as a part of their installation script.
# Until the standard Puppet module picks up the change, handle this
# manually before we install RVM. -- ODS 5-Nov-2014
exec {
  'import_rvm_gpg_key':
    command => 'gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3',
    unless => 'gpg --list-keys D39DC0E3',
}

rvm_system_ruby {
  'ruby-1.8.7':
    ensure      => 'present',
    default_use => true,
    require => Exec['import_rvm_gpg_key'],
}

exec { 'io-lang-debian-package':
  command => 'unzip -o /vagrant/iobin-linux-x64-deb-current.zip',
  unless => 'dpkg-query -W iolanguage',
  cwd     => '/home/vagrant/',
  require => Package['unzip'],
}

package { 'iolanguage':
  ensure   => present,
  provider => dpkg,
  source   => '/home/vagrant/IoLanguage-2013.11.04-Linux-x64.deb',
  require  => Exec['io-lang-debian-package'],
}

package {
  ['unzip', 'swi-prolog', 'haskell-platform', 'erlang', 'leiningen', 'scala']:
   ensure => present,
}
