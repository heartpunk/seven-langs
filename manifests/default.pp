include rvm

rvm_system_ruby {
  'ruby-1.8.7':
    ensure      => 'present',
    default_use => true;
}
