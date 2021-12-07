$(document).on('turbolinks:load', function(){
  $('#pills-anserwered-tab').on('show.bs.tab', function(){
    $('#changing-title').text('回答済みの');
  });
  $('#pills-unanserwered-tab').on('show.bs.tab', function(){
    $('#changing-title').text('未回答の');
  });
});
