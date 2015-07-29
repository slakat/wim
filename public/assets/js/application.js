// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require select2
//= require highcharts
//= require highcharts/highcharts-more
//= require highcharts/modules/data
//= require highcharts/modules/heatmap
//= require highcharts/modules/exporting
//= require home
//= require tooltips
//= sand-signika
//= jquery-ui
//= bootstrap
//= require_tree .

$(document).ready(initializeClickables);
$(document).on('page:load', initializeClickables);
$(document).ready(function() { $(".select2").select2(); });

function initializeClickables() {
    $('.clickable').click(function(e) {
        if(e.target == this) {
            window.location.href = $(this).attr('data-href');
        }
    });
}