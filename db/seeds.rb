# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Role.create(slug: 'admin')
Role.create(slug: 'user')

alan = User.create(
  first_name: 'Alan',
  last_name: 'Long',
  email: 'alan.d.long@protonmail.com',
  password: 'qwerty',
  password_confirmation: 'qwerty'
)
# Give Alan the admin role
alan.add_role(:admin)

# Create Zach
zach = User.create(
  first_name: 'Zach',
  last_name: 'Young',
  email: 'zach@codefiworks.com',
  password: 'qwerty',
  password_confirmation: 'qwerty'
)
zach.add_role(:admin)