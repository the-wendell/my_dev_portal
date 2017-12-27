
ready = function() {
  $("#job-applications").colResizable({
    fixed:false,
    liveDrag:true,
    gripInnerHtml:"<div class='grip'></div>",
    draggingClass:"dragging"
  });
}
$(document).ready(ready)
$(document).on('turbolinks:load', ready)
