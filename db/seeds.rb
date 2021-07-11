# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create email: "admin@tapestry.fm", password: "test123", password_confirmation: "test123"
user.lists << List.new(inbox: true, owner: user)

# create some tracks
track1 = ListEntry.init_from_url(url: "https://tropus.bandcamp.com/track/kapteyn-b")

track2 = ListEntry.init_from_url(url: "https://tropus.bandcamp.com/track/proxima-a")

user.inbox.list_entries << track1
user.inbox.list_entries << track2

# add them to a new list
tapestry = List.create(owner: user, name: "Ambient stuff")
tapestry.list_entries << track1
tapestry.list_entries << track2
