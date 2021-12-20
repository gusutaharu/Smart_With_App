$(document).on('turbolinks:load', function(){
  $(function() {
    $('.search-sort a[data-bs-toggle="pill"]').on('click', function (e) {
      let tabName = e.target.href;
      let itmes = tabName.split("#");
      Cookies.set("openTag", itmes[1], { expires: 1 });
    });
    let url = location.href;
    if((url.match(/search/))){
      if (Cookies.get("openTag")){
        $('a[data-bs-toggle="pill"]').removeClass('active');
        $('a[href="#' + Cookies.get("openTag") +'"]')[0].click(); 
      }
    }else{
      Cookies.remove("openTag");
    }
  });
});
