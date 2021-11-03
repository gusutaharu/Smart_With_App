$(document).on('turbolinks:load', function() {
  $('#question_title').on('input', function(){
    let titleValue = $('#question_title').val();
    $('#output-title').text(titleValue);
  });

  $('#question_information').on('input', function(){
    let informationValue = $('#question_information').val();
    $('#output-information').text(informationValue);
  });

  $('#question_content').on('input', function(){
    let contentValue = $('#question_content').val();
    $('#output-content').text(contentValue);
  });
});
