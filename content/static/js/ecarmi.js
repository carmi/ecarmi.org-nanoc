/*
 *  ecarmi.js - Some custom javascript UI touches for ecarmi.org
 *
 * @author Evan Carmi
 */

var contact_form_submit = '#contact-form input[type=submit]';

$(window).load(function() {
  $('.action-descriptions p:not(:first)').hide({duration: 0});
  $(contact_form_submit).hide({duration: 0})

  $('#contact-form *').bind('mouseover focus', function() {
    $(contact_form_submit).show({duration: 0})
  });
});

var hideall = function(duration) {
  $('.action-descriptions p').stop( false, true).hide({duration: duration});
};

$('.action a').click(function() {
  hideall(0);
  var section = this.attributes['href'].value.substring(1);
  $(".action-descriptions ." + section).fadeIn(700);
  return false;
});

var success_html = "<b>I got it! Thanks</b>"
