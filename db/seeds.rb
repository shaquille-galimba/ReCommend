# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create(username: "User", email: "user@example.com" password: "Password")
shaq = User.create(username: "ShaqRiver", email: "shaqriver@example.com" password: "Password")
extra = User.create(username: "TestExtra", email: "test@example.com" password: "Password")

dnd = Category.create(name: "D&D Show")
game = Category.create(name: "Game")

d20 = Brand.create(name: "Dimension20", category: dnd)
naddpod = Brand.create(name: "NADDPOD", category: dnd)
crit = Brand.create(name: "Critical Role", category: dnd)

div = Brand.create(name: "Divinity Original Sin:2", category: game)
valorant = Brand.create(name: "Valorant", category: game)
mario = Brand.create(name: "Mario Kart", category: game)

Recommend.create(user: shaq, brand: d20, comment: "Best D&D play show!")
Recommend.create(user: shaq, brand: naddpod, comment: "Best D&D Podcast!")
Recommend.create(user: user, brand: crit, comment: "Mighty Nine!")
Recommend.create(user: shaq, brand: div, comment: "Mind-blowing isometric RPG game!")
Recommend.create(user: user, brand: div, comment: "For Rivellon!")
Recommend.create(user: shaq, brand: valorant, comment: "CSGO-like and Overwatch-like shooting game.")
Recommend.create(user: extra, brand: mario, comment: "It's a me, Mario!")
