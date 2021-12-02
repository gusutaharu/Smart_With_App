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

  $('#hardware_category').on('change', function(){
    let hardwareCategory = document.getElementById('hardware_category').value;
    $('#output-category_parent').text(hardwareCategory);
    $('#output-category_child').text('');
    $('#output-category_grandchild').text('');
  });

  $('.listing-product-detail_category').on('change', '#child_category', function(){
    let os_category = document.getElementById('child_category').value;
    $('#output-category_child').text(os_category);
    $('#output-category_grandchild').text('');
  });

  $('.listing-product-detail_category').on('change', '#grandchild_category', function(){
    let condition_category = document.getElementById('grandchild_category').value;
    $('#output-category_grandchild').text(condition_category);
  });
});
