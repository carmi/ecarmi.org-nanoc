/*
 *  ecarmi.js - Some custom javascript UI touches for ecarmi.org
 *
 * Copyright (c) 2011, Evan Carmi
 */
$(document).ready(function() {
  // Setup flybar animation by disabling default css hover events.
  $('section#articles ul li article div.meta-flybar').css('visibility', 'visible');
  $('section#articles ul li article div.meta-flybar').hide();
  $('section#articles ul li article').hover(
    function() {
      $('header').hide();
      $(this).children('div.meta-flybar').fadeIn('fast', function() {
        });
    },
    function() {
      $(this).children('div.meta-flybar').fadeOut('fast', function() {
          $('header').fadeIn('slow')
        });
      }
    );
});


/*
 *
  */
