
admin_user = User.create(email: "admin@email.com", password: "123456")
admin_user.add_role :admin
