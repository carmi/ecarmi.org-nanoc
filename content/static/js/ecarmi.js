/*
 *  ecarmi.js - Some custom javascript UI touches for ecarmi.org
 *
 * @author Evan Carmi
 */

// Make main landing links scrollTo respective sections.
var duration = 850;

$('div.landing li').each(function() {
  // Get value of href to scroll to
  var section = $($(this).find('a').first().attr('href'));

  $(this).click(function() {
    $.scrollTo($(section), duration); 
    return false;
  });
});
