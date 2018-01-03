$(function(){
  // always pass csrf tokens on ajax calls
  $.ajaxSetup({
    headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') }
  });
});

$(document).on('change', '#user_options', function(event) {
  var user_options = $(this).val();
  $.ajax({
    type: "PATCH",
    url: "/select_active_portfolio",
    data: { id: user_options }
  })
})
