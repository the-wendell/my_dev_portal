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
//= require turbolinks
//= require jquery3
//= require jquery
//= require jquery.minicolors
//= require popper
//= require bootstrap-sprockets
//= require_tree .

/*
 * Replace all SVG images with inline SVG
 */
 $(document).ready(function() {
     $('img[src$=".svg"]').each(function() {
         var $img = jQuery(this);
         var imgURL = $img.attr('src');
         var attributes = $img.prop("attributes");

         $.get(imgURL, function(data) {
             // Get the SVG tag, ignore the rest
             var $svg = jQuery(data).find('svg');

             // Remove any invalid XML tags
             $svg = $svg.removeAttr('xmlns:a');

             // Loop through IMG attributes and apply on SVG
             $.each(attributes, function() {
                 $svg.attr(this.name, this.value);
             });

             // Replace IMG with SVG
             $img.replaceWith($svg);
         }, 'xml');
     });
 });
