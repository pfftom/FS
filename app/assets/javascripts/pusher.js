$(function(){
  var pusher = new Pusher(window.PUSHER_KEY);
  var channel = pusher.subscribe(window.PUSHER_CHANNEL);

  channel.bind("new_selection", function(data){
    $("#selection").prepend(data.selection);
    $("#player-" + data.player_id.toString()).hide();
  });

  channel.bind("update_team", function(data){
    $("#drafted-team").append("<li>" + data.position + " " + data.name + "</li>");
  });
});
