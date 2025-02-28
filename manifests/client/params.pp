# @api private
class mongodb::client::params inherits mongodb::globals {
  $package_ensure = pick($mongodb::globals::client_package_ensure, 'present')
  $manage_package = pick($mongodb::globals::manage_package, $mongodb::globals::manage_package_repo, false)

  if $manage_package {
    $package_name = "mongodb-${mongodb::globals::edition}-shell"
  } else {
    $package_name = $facts['os']['family'] ? {
      'Debian' => 'mongodb-clients',
      'Redhat' => "mongodb-${mongodb::globals::edition}-shell",
      default  => 'mongodb',
    }
  }
}
