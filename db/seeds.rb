# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Receptionist.create(email: "foo@bar.net", password: "foobarbarfoo")
User.create(email: "foobar@foo.eu", first_name: "Krzysztof", last_name: "Jarzyna", password: "foobarbarfoo")