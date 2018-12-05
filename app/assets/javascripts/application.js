// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require semantic-ui
//= require jquery.ba-url
//= require_tree .
$(document).on('turbolinks:load', function() {
  $('.ui.dropdown').dropdown();
  routes = {
    '/': '#home',
    '/patients': '#patients',
    '/doctors': '#doctors',
    '/appointments': '#appointments',
    '/specializations': '#specializations'
  };
  Object.keys(routes).forEach(function(key) {
    if (key.length > 1) {
      arr = Array.from(key)
      arr.splice(0,1)
      arr = arr.join("").toString()
      if (window.location.pathname.includes(arr)) {
        $(routes[key]).addClass('active');
        $(routes['/']).removeClass('active');
      }
    } else if (key.length === 1) {
      $(routes[key]).addClass('active');
    }
  });
});
