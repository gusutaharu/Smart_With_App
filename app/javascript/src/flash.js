$(document).on('turbolinks:load', function(){
  $(function(){
    setTimeout("$('.alert-success,.alert-info').fadeOut('slow')", 600);
  })
});
