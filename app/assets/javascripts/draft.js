$(document).ready(function(){
  var currentPage = location.pathname;
  var playersPath = "/players"
  if(currentPage != playersPath){
    $("#player-tabs").on("click", ".player-select", function(event){
      var subPath = currentPage.substring(0, currentPage.length - playersPath.length);
      var element = $(event.target);
      $.post(subPath + "/rosters", {
        player_name: element.parent().context.innerHTML
      }).done(function(){
        element.parent().hide();
      });
    });
  }
});
