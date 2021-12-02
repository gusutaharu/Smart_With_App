$(document).on('turbolinks:load', function() {
  function appendOption(category){
    let html = `<option value="${category.name}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  function appendChildrenBox(insertHTML){
    let childSelectHtml = '';
    childSelectHtml = `<div class='listing-select-wrapper_added' id= 'children_wrapper'>
                        <div class='listing-select-wrapper_box'>
                          <select class='listing-select-wrapper_box--select' id='child_category' name='category_id'>
                            <option value='---' data-category='---'>---</option>
                            ${insertHTML}
                          </select>
                        </div>
                      </div>`;
    $('.listing-product-detail_category').append(childSelectHtml);
  }
  function appendGrandchildrenBox(insertHTML){
    let grandchildSelectHtml = '';
    grandchildSelectHtml = `<div class='listing-select-wrapper_added' id= 'grandchildren_wrapper'>
                              <div class='listing-select-wrapper_box'>
                                <select class='listing-select-wrapper_box--select' id='grandchild_category' name='category_id'>
                                  <option value='---' data-category='---'>---</option>
                                  ${insertHTML}
                                </select>
                              </div>
                            </div>`;
    $('.listing-product-detail_category').append(grandchildSelectHtml);
  }
  $('#hardware_category').on('change', function(){
    let hardwareCategory = document.getElementById('hardware_category').value;
    if (hardwareCategory != "---"){
      $.ajax({
        url: 'get_category_os',
        type: 'GET',
        data: { hardware_name: hardwareCategory },
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
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#children_wrapper').remove();
      $('#grandchildren_wrapper').remove();
    }
  });
  $('.listing-product-detail_category').on('change', '#child_category', function(){
    let childId = $('#child_category option:selected').data('category');
    if (childId != "---"){
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
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#grandchildren_wrapper').remove();
    }
  });
});
