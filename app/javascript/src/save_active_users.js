$(document).on('turbolinks:load', function(){
  $(function() {
    $('.users-sort a[data-bs-toggle="pill"]').on('click', function (e) {
      let tabName = e.target.href;
      let itmes = tabName.split("#");
      Cookies.set("openUsersTag", itmes[1], { expires: 1 });
    });
    let url = location.href;
    if(url.match(/^(?=.*users)(?!.*edit)/)){
      if(Cookies.get("openUsersTag")){
        $('a[data-bs-toggle="pill"]').removeClass('active');
        $('a[href="#' + Cookies.get("openUsersTag") +'"]')[0].click();
      }
    }else{
      Cookies.remove("openUsersTag");
    }
  });
});
