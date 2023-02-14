# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


p "Delete everything"
User.destroy_all
Chatroom.destroy_all

p "Create Users"
User.create!(email: "toto@toto.com", password: "azerty", nickname: "Toto")
User.create!(email: "tata@tata.com", password: "azerty", nickname: "Tata")
p "finish users"
p "Create a chatroom"
Chatroom.create!(name: "Général")
p "Finish chatroom"
p "Create messages"
Message.create!(content: "Hello !", user: User.first, chatroom: Chatroom.first)
Message.create!(content: "How are you ?", user: User.last, chatroom: Chatroom.first)
p "Finish messages"
