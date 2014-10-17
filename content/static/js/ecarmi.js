/*
 *  ecarmi.js - Some custom javascript UI touches for ecarmi.org
 *
 * @author Evan Carmi
 */

$(window).load(function() {
  hideall(0);
});

var hideall = function(duration) {
  $('.action-descriptions p').hide({duration: duration});
};

$('.action a').click(function() {
  hideall(0);
  var section = this.attributes['href'].value.substring(1);
  $(".action-descriptions ." + section).fadeIn(700);
  return false;
});
