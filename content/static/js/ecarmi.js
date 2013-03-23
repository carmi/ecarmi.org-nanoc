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

// Hide nav links
$(window).load(function() {
  $('nav.sidebar div.links').fadeOut({duration: 2500});
});

$('nav.sidebar div.links').mouseover(
    function () {
      if($(this).is(':animated')) {
         $(this).stop().animate({opacity:'100'});
      }
    }
);

$('nav.sidebar a.toggle').click(function() {
  $('nav.sidebar div.links').fadeToggle({duration: '50'}, function() {
    // Animation complete.
    $('nav.sidebar').toggleClass("visible");
  });
  return false;
});
