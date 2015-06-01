;$(function(e){ 

  $(".popup").click(function(e){
    e.preventDefault();
    var width = 600;
    var height = 500;
    var left = parseInt((screen.availWidth/2) - (width/2));
    var top = parseInt((screen.availHeight/2) - (height/2));
    var windowFeatures = "width=" + width + ",height=" + height + ",status,resizable,left=" + left + ",top=" + top + "screenX=" + left + ",screenY=" + top;
    window.open($(this).attr("href"), "popup", windowFeatures);
  });

});