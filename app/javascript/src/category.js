$(document).on('turbolinks:load', function() {
  function appendOption(category){
    let html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  function appendChildrenBox(insertHTML){
    let childSelectHtml = '';
    childSelectHtml = `<div class='category-select-wrapper_added' id= 'children_wrapper'>
                        <div class='category-select-wrapper_box'>
                          <select class='category-select-wrapper_box-select' id='child_category' name='question[category_ids][]'>
                            <option data-category=''></option>
                            ${insertHTML}
                          </select>
                        </div>
                      </div>`;
    $('.category_form').append(childSelectHtml);
  }
  function appendGrandchildrenBox(insertHTML){
    let grandchildSelectHtml = '';
    grandchildSelectHtml = `<div class='category-select-wrapper_added' id= 'grandchildren_wrapper'>
                              <div class='category-select-wrapper_box'>
                                <select class='category-select-wrapper_box-select' id='grandchild_category' name='question[category_ids][]'>
                                  <option data-category=''></option>
                                  ${insertHTML}
                                </select>
                              </div>
                            </div>`;
    $('.category_form').append(grandchildSelectHtml);
  }
  $('#hardware_category').on('change', function(){
    let hardwareId = document.getElementById('hardware_category').value;
    if (hardwareId != ""){
      $.ajax({
        url: 'get_category_os',
        type: 'GET',
        data: { hardware_id: hardwareId },
        dateType: 'json'
      })
      .done(function(children){
        $('#children_wrapper').remove();
        $('#grandchildren_wrapper').remove();
        let insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChildrenBox(insertHTML);
      })
      .fail(function(){
        alert('??????????????????????????????????????????');
      })
    }else{
      $('#children_wrapper').remove();
      $('#grandchildren_wrapper').remove();
    }
  });
  $('.category_form').on('change', '#child_category', function(){
    let childId = $('#child_category option:selected').data('category');
    if (childId != ""){
      $.ajax({
        url: 'get_category_condition',
        type: 'GET',
        data: { os_id: childId },
        dataType: 'json'
      })
      .done(function(grandchildren){
        if (grandchildren.length != 0) {
          $('#grandchildren_wrapper').remove();
          let insertHTML = '';
          grandchildren.forEach(function(grandchild){
            insertHTML += appendOption(grandchild);
          });
          appendGrandchildrenBox(insertHTML);
        }
      })
      .fail(function(){
        alert('??????????????????????????????????????????');
      })
    }else{
      $('#grandchildren_wrapper').remove();
    }
  });
});
