# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#didn't $ rails db:seed

#複数のユーザーを一気に作る
#99.times do |n|
#  name  = "太郎#{n + 1}"
#  email = "example-#{n+1}@railstutorial.org"
#  password = "password"
#  User.create!(name: name,
#              email: email,
#              password:              password,
#              password_confirmation: password)
#end

#ここから下がエラー上までは作成可
#relationship
#users = User.all
#user  = users.first
#following = users[2..50]
#followers = users[3..40]
#following.each { |followed| user.followed(followed) }
#followers.each { |follower| follower.follower(user) }