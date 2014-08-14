$(document).ready(function(){
  var pusher = new Pusher(window.PUSHER_KEY);
  var channel = pusher.subscribe(window.PUSHER_CHANNEL);
  var draftingTeam = "";
  var pick = 0;

  channel.bind("new_selection", function(data){
    $("#selection").prepend(data.selection);
    $("#player-" + data.player_id.toString()).hide();
  });

  channel.bind("update_team", function(data){
    $("#drafted-team").append("<li>" + data.position + " " + data.name + "</li>");
  });

  channel.bind("on_the_clock", function(data){
    $("#current-picker").text(data.team);
    draftingTeam = data.team;
    pick = data.pick;
  });

  $(".draft-select").click(function(event){
    if(draftingTeam == team.name){
      event.preventDefault();
      var element = $(event.target);
      $.post(element.context.pathname, {
        player_name: element.context.text
      }).done(function(){
        nextPick();
        element.hide();
      });
    }
  });

  $("#start-draft").click(function(event){
    event.preventDefault();
    startDraft();
  });

  function startDraft(){
    sendPickToServer(pick);
  }

  function nextPick(){
    pick += 1;
    sendPickToServer(pick);
  }

  function sendPickToServer(pick){
    $.ajax({
      url: location.pathname,
      type: "PATCH",
      data: { pick: pick }
    });
  }
});
