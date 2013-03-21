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
    // Log click with mixpanel
    mpq.track("[homepage]: " + $(this).first('a').text() +  " clicked");
    return false;
  });
});

$('nav.sidebar div.links').hide();
$('nav.sidebar a.toggle').click(function() {
  $('nav.sidebar div.links').animate({width: 'toggle', duration: 'slow'}, function() {
    // Animation complete.
    $('nav.sidebar').toggleClass("visible");
  });
  return false;
});
