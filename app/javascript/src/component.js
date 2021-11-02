$(function(){
  $('#question_question_images').on('change', function (e) {

    if(e.target.files.length > 4){

      alert('一度に投稿できる画像は4枚までです。');
      $('#question_question_images').val = "";

      for(let i = 0; i < 4; i++) {
        $(`#preview_${i}`).attr('src', "");
      }

    }else{
      let reader = new Array(4);

      for(let i = 0; i < 4; i++) {
        $(`#preview_${i}`).attr('src', "");
      }

      for(let i = 0; i < e.target.files.length; i++) {
        reader[i] = new FileReader();
        reader[i].onload = finisher(i,e); 
        reader[i].readAsDataURL(e.target.files[i]);

        function finisher(i,e){
          return function(e){
          $(`#preview_${i}`).attr('src', e.target.result);
          }
        }
      }
    }
  });
});