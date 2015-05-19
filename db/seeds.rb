# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Admin.create(email: "admin@fitness.club", password: "adminpassword")
Receptionist.create(email: "receptionist@fitness.club", password: "receptionistpassword")
User.create(email: "user@fitness.club", first_name: "Test", last_name: "User", password: "userpassword")
