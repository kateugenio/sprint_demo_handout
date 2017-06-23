$(document).ready(function(){
  $('.addToBL').click(function(){
    var userStoryID = $(this).closest('td').attr('id');
    var closestRow = $(this).closest('tr');
    //console.log(userStoryID);
    $(this).button('toggle').attr('disabled', 'disabled');
    var data = {};
    data['user_story_id'] = userStoryID;
    $.ajax({
      url: '/dashboard/update_project',
      contentType: 'application/json',
      dataType: JSON,
      data: JSON.stringify(data),
      type: 'POST',
      success: function(res) {
        //console.log('success!');
        $(closestRow).notify("Success!", {
          clickToHide: true,
          autoHideDelay: 2000,
          className: "success",
          position: "top center"
        });
      }
    });
  });

  $('.panel-heading').click(function(e){
    e.preventDefault();
    var targetPanel = $(this).siblings().collapse('toggle');
    var span = $(this).find('span');
    if ($(span).attr('class') == 'glyphicon glyphicon-chevron-down') {
      $(span).attr('class','glyphicon glyphicon-chevron-up');
    }
    else {
      $(span).attr('class', 'glyphicon glyphicon-chevron-down');
    };
    //console.log(targetPanel);
    //$(targetPanel).collapse('toggle');
  });
});
