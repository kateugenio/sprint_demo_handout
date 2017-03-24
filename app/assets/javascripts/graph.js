$(document).ready(function(){
  $('.graph-submit').click(function(){
    $('#graph-img').attr("src",$('#graphlink').val())
    link = $('#graphlink').val();
  });
});
