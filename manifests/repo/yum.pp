# PRIVATE CLASS: do not use directly
class mongodb::repo::yum inherits mongodb::repo {
  # We try to follow/reproduce the instruction
  # http://docs.mongodb.org/manual/tutorial/install-mongodb-on-red-hat-centos-or-fedora-linux/

  if $mongodb::repo::ensure == 'present' or $mongodb::repo::ensure == true {
    yumrepo { 'mongodb':
      name           => $mongodb::repo::namever,
      descr          => $mongodb::repo::description,
      baseurl        => $mongodb::repo::location,
      gpgcheck       => '1',
      gpgkey         => $mongodb::repo::gpgkey,
      enabled        => '1',
      proxy          => $mongodb::repo::proxy,
      proxy_username => $mongodb::repo::proxy_username,
      proxy_password => $mongodb::repo::proxy_password,
    }
    Yumrepo['mongodb'] -> Package<| tag == 'mongodb_package' |>
  }
  else {
    yumrepo { 'mongodb':
      ensure => absent,
      name   => $mongodb::repo::namever,
    }
  }
}
