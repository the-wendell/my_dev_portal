/*
On click hides/unhides the div that matches the element id.
*/

$(document).ready(function(){
  $(".feature").click(function () {
      const id = this.id
      if ($(`#${id}-detail`).hasClass("hidden")) {
        $(".detail").addClass("hidden");
        $(".feature").removeClass("active-feature");
        $(`#${id}-detail`).removeClass("hidden");
        $(this).addClass("active-feature");

        $('html, body').animate({
            scrollTop: $(`#${id}-detail`).offset().top
        }, 300);
      }
      else {
        $(`#${id}-detail`).addClass("hidden");
        $(".feature").removeClass("active-feature");
      }
  });
})
