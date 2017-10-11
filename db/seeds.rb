# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Users
user = User.new
user.email = 'superman@gmail.com'
user.name = 'Superman'
user.age = 97
user.is_admin = true
user.password = '123456'
user.password_confirmation = '123456'
user.save!

# Status
Status.create(name: 'Open')
Status.create(name: 'In progress')
Status.create(name: 'Wait')
Status.create(name: 'Close')