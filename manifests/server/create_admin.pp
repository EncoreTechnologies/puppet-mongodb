class mongodb::server::create_admin {
  $admin_password_unsensitive = if $mongodb::server::admin_password =~ Sensitive[String] {
    $mongodb::server::admin_password.unwrap
  } else {
    $mongodb::server::admin_password
  }

  exec { 'create-mongodb-admin':
    command => "/usr/bin/mongo admin --eval 'db.createUser({user: \"${mongodb::server::admin_username}\", pwd: \"${admin_password_unsensitive}\", roles: ${mongodb::server::admin_roles.to_json}})'",
    unless  => "/usr/bin/mongo admin --eval 'db.getUser(\"${mongodb::server::admin_username}\")' | grep -q '\"user\" : \"${mongodb::server::admin_username}\"'",
    require => Service['mongodb'],
  }

  # Make sure it runs before other DB creation
  Exec['create-mongodb-admin'] -> Mongodb::Db <| title != 'admin' |>
}
