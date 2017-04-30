if ENV["deseed"]
  User.where(
    name: ENV["KOHRVID_ADMIN_NAME"],
    email: ENV["KOHRVID_ADMIN_EMAIL"],
    crypted_password: ENV["KOHRVID_ADMIN_PASSWORD"],
    admin: true
  ).destroy_all
else
  User.create(
    name: ENV["KOHRVID_ADMIN_NAME"],
    email: ENV["KOHRVID_ADMIN_EMAIL"],
    password: ENV["KOHRVID_ADMIN_PASSWORD"],
    password_confirmation: ENV["KOHRVID_ADMIN_PASSWORD"],
    bio: ENV["KOHRVID_ADMIN_BIO"],
    admin: true
  )
end
