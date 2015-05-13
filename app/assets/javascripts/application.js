// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require twitter/bootstrap
//= require_tree .
$( document ).ready(function() {
  $('#post-table').DataTable({});

  $('a.filter-tag').on('click', function(e) {
    e.preventDefault();
    var tag = $(this).text();
    if ( tag == 'All') {
      $("#post-table td.post-tag").parent().show();
    } else {
      $("#post-table td.post-tag:contains('" + tag +"')").parent().show();
      $("#post-table td.post-tag:not(:contains('" + tag +"'))").parent().hide();
    }
  });
});
