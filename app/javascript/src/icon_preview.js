$(document).on('turbolinks:load', function() {
  $('#user_user_icon').on('change',function(e){
    let reader = new FileReader();
    reader.onload = function(e){
      $('#icon_preview span').remove();
      $('#icon_preview img').attr({
        src: e.target.result,
        id: 'icon_big'
      });
      $('#icon_preview p').text('変更後の画像');
    }
    reader.readAsDataURL(e.target.files[0]);
  })
});
