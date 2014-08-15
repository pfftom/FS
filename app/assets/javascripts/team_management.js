$(function(){
  $(".activate-player").click(function(event){
    toggleActive($(event.target).parents("li"));
  });

  $(".bench-player").click(function(event){
    toggleActive($(event.target).parents("li"));
  });

  function toggleActive(element){
    var patchUrl = "/leagues/" + leagueId.toString()
      + "/teams/" + teamId.toString();
    var player = element.children("span")[0].innerText;
    $.ajax({
      url: patchUrl,
      data: { player: player },
      type: "PATCH"
    }).done(function(){
      location.reload();
    });
  }
});
