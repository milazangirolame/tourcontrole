import "bootstrap";

//= require jquery-ui.all
//= require jquery.ui.datepicker
//= require jquery.ui.datepicker-en
//= require jquery.ui.datepicker-es
//= require jquery.ui.datepicker-fr
$("input.datepicker").each(function(input) {
  $(this).datepicker({
    dateFormat: "yy-mm-dd",
    altField: $(this).next()
  })

  // If you use i18n-js you can set the locale like that
  $(this).datepicker("option", $.datepicker.regional[I18n.currentLocale()]);
})
