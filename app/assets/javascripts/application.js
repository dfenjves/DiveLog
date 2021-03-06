// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require bootstrap
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require best_in_place
//= require best_in_place.purr
//= require fancybox/jquery.fancybox.pack
//= require_tree .

ATTRIBUTES_IN_UNITS = ["visibility", "start_air", "end_air", "temperature", "depth"];

var changeUnits = function(){
  for( var i=0; i < ATTRIBUTES_IN_UNITS.length; i++ ) {
    if (($("span[data-attribute='" + ATTRIBUTES_IN_UNITS[i] + "']").text() == "" || $("span[data-attribute='" + ATTRIBUTES_IN_UNITS[i] + "']").text() == "—" )) {
      $("." + ATTRIBUTES_IN_UNITS[i]).hide();
    }
    if( /\d/.test($("."+ATTRIBUTES_IN_UNITS[i]+"-contents").text()) ){
      console.log(/\d/.test($("."+ATTRIBUTES_IN_UNITS[i]+"-contents").text()));
      $("." + ATTRIBUTES_IN_UNITS[i]).show();
    }
  }
}

jQuery(document).ready(function($) {

  $(".best_in_place").best_in_place();

  changeUnits();

  if ($('#recentdives').length > 0) {
    $('#recentdives').vTicker();
  }

  $('.change-units').submit( function(e) {
    changeUnits();
  });

  $(".times").on('select', function(e) {
    $(".times input").val('');
    $(".times input").attr('placeholder', 'Please enter a time');
  });

  // $(".times").on('change', function(e) {
  //   $(".length-of-time").prepend("<%= @dive.total_time_in_minutes %>");
  // });

  if ( $(window).width() < 1000 ) {
    $('body').addClass('bg');
  } 
  else {
    $('body').addClass('bg');
    $('div.intro-text').addClass('intro-padding');
  }
  $(".clickableRow").click(function() {
    window.document.location = $(this).attr("href");
  });
});
