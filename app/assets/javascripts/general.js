// ToDo: separate files... 

;$(function(e){

  $(".conversations-link").click(function(e){
    event.preventDefault();
    $(this).addClass('active');
    $('.related-link').removeClass('active');
    $(".conversations").show();
    $(".related").hide();
  });
  $(".related-link").click(function(e){
    event.preventDefault();
    $(this).addClass('active');
    $('.conversations-link').removeClass('active');
    $(".conversations").hide();
    $(".related").show();
  });

  $('#card_title').focus();

  $('.field .input').blur(function() {
    $(this).parents('.field').removeClass('active');
  }).focus(function() {
    $(this).parents('.field').addClass('active');
  });

  $('.media_upload_image_link').click(function() {
    event.preventDefault();
    $('.upload_media').hide();
    $('.media_upload_image_cont').show();
  });
  $('.media_upload_video_link').click(function() {
    event.preventDefault();
    $('.upload_media').hide();
    $('.media_upload_video_cont').show();
  });
  $('.upload_media_back_to_selector').click(function() {
    event.preventDefault();
    $('.upload_media').hide();
    $('.media_upload_selector').show();
  });

});
