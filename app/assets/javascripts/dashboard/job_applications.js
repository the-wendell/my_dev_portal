$(document).ready(function(){
  $("#filter-collapse-button").click(function () {
        $(".filter-search-box").addClass("hidden");
        $(".show-main").css("grid-template-columns", "auto");
        $("#filter-expand-button").removeClass("hidden")
  });

  $("#filter-expand-button").click(function () {
        $("#filter-expand-button").addClass("hidden");
        $(".show-main").css("grid-template-columns", "265px auto minmax(0px, 265px)");
        $(".filter-search-box").removeClass("hidden")
  });
});
