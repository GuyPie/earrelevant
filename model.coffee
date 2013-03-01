Artists = new Meteor.Collection("artists")
Albums = new Meteor.Collection("albums")

radiohead_albums = [{name: "OK Computer"}, {name: "Kid A"}]
Artists.insert {name: "Radiohead", \
				albums: radiohead_albums}