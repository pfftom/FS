$(document).ready(function(){
  $("#player-tabs").tabs();

  var currentPage = location.pathname;
  var playersPath = "/players";
  var path = currentPage.substring(currentPage.length - playersPath.length);

  if(currentPage.length != playersPath.length && playersPath == path){
    if(hasDrafted && isAtRosterLimit){
      $(".add-player-button").show();
      $("#player-tabs").on("click", ".add-player", function(event){
        event.preventDefault();
        var element = $(event.target).parents("tr");
        var player = element.attr("id");
        var teamPath = "/teams/" + teamId.toString() + "/rosters";
        $.post(teamPath, {
          player: player
        }).done(function(){
          element.hide();
        });
      });
    }
  }
});
