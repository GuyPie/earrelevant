if Meteor.is_client
  Template.hello.greeting = ->
    "Welcome to FirstApp."
 
  Template.hello.events = "click input": ->
    console.log "You pressed the button"

  Meteor.startup =>
    $("body").layout { applyDefaultStyles: true }

if Meteor.is_server
  Meteor.startup =>
    # code to run on server at startup
