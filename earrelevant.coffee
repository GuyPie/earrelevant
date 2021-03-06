Albums = new Meteor.Collection("albums")

if Meteor.isClient
  Template.album_list.albums =->
   return Albums.find({})

  Template.input.events
    "click button": ->
      artist = $("input.artist").val()
      album = $("input.album").val()

      Meteor.call "getAlbumArt",
        artist,
        album,
        (error, result) ->
          if not error?
            Albums.insert
              name: album
              artist: artist
              cover: result

  Template.album_info.events
    "click .close": ->
      Albums.remove
        name: this.name
        artist: this.artist

  Template.album_info.rendered =->
    $cover = $(this.find(".cover"))
    console.log($cover)
    Meteor.defer =>
      $cover.removeClass("loading", 1000, "easeOutBounce")

if Meteor.isServer
  Meteor.startup =>
    Future = NodeModules.require("fibers/future")
    LastFmNode = NodeModules.require("lastfm").LastFmNode
    lastfm = new LastFmNode 
      api_key: "d57272a26ba342b4e2ca59617a7ab7df"
      secret: "7e71cc886f09e5dc696af9ab16beb8ba"

    Meteor.methods
      getAlbumArt: (artist, album) ->
        fut = new Future()
        lastfm.request "album.getInfo",
          artist: artist
          album: album
          handlers:
              success: (data) ->
                  fut.ret(data.album.image[2]["#text"])
              error: (error) ->
                  console.log("Error: " + error.message)
                  fut.ret("/images/default_album.gif")


        return fut.wait()