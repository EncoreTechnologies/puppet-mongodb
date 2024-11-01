class mongodb::server::create_admin {
  $admin_password_unsensitive = if $mongodb::server::admin_password =~ Sensitive[String] {
    $mongodb::server::admin_password.unwrap
  } else {
    $mongodb::server::admin_password
  }

  mongodb::db { 'admin':
    user            => $mongodb::server::admin_username,
    auth_mechanism  => $mongodb::server::admin_auth_mechanism,
    password        => $admin_password_unsensitive,
    roles           => $mongodb::server::admin_roles,
    update_password => $mongodb::server::admin_update_password,
  }

  # Make sure it runs before other DB creation
  Mongodb::Db['admin'] -> Mongodb::Db <| title != 'admin' |>
}
