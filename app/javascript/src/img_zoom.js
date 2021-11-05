$(document).on('turbolinks:load', function(){
  $('.zoom').on('click',function(){
    let imgSrc = $(this).children().attr('src');
    $('.bigimg').children().attr('src', imgSrc);
    $('.img-zoom').fadeIn();
    $('body html').css('overflow-y', 'hidden');
    return false
  });
  $('.img-zoom').on('click',function(){
    $('.img-zoom').fadeOut();
    $('body,html').css('overflow-y', 'visible');
  });
});
