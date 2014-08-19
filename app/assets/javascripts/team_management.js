$(function(){
  $(".activate-player").click(function(event){
    toggleActive(event);
  });

  $(".bench-player").click(function(event){
    toggleActive(event);
  });

  function toggleActive(event){
    var patchUrl = "/leagues/" + leagueId.toString()
      + "/teams/" + teamId.toString();
    var player = getPlayer(event);
    sendToServer(patchUrl, player, "PATCH");
  }

  $("#edit-team").click(function(event){
    $(".drop-player").toggle();
    $(".impact-player").toggle();
  });

  $(".impact-player").click(function(event){
    var patchUrl = "/teams/" + teamId.toString() + "/rosters";
    var player = getPlayer(event);
    sendToServer(patchUrl, player, "PATCH");
  });

  $(".drop-player").click(function(event){
    var url = "/teams/" + teamId.toString() + "/rosters";
    var player = getPlayer(event);
    sendToServer(url, player, "DELETE");
  });

  function getPlayer(event){
    return $(event.target).parents("li").children("span")[0].innerText;
  }

  function sendToServer(url, player, type){
    $.ajax({
      url: url,
      data: { player: player },
      type: type
    }).done(function(){
      location.reload();
    });
  }
});
