/*
On click hides/unhides the div that matches the element id.
*/

$(document).ready(function(){
  $(".feature").click(function () {
      var id = this.id
      var element = id.concat('-detail')
      if ($('#' + element).hasClass("hidden")) {
        $(".detail").addClass("hidden");
        $(".feature").removeClass("active-feature");
        $('#' + element).removeClass("hidden");
        $(this).addClass("active-feature");

        $('html, body').animate({
            scrollTop: $('#' + element).offset().top
        }, 300);
      }
      else {
        $('#' + element).addClass("hidden");
        $(".feature").removeClass("active-feature");
      }
  });
})
