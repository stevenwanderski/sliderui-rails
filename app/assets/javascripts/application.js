//= require jquery
//= require jquery_ujs
//= require jquery-ui/widgets/sortable

$(document).on('click', '[data-close]', function() {
  $(this).parents('[data-flash]').remove();
});