$(document).ready(function() {

  $('#image-field').on('change', function(){
    $(this).closest('form').ajaxSubmit({
      success: function(ret){
        console.log(ret);
        if (ret.result){
          var img = new Image();
          img.src = ret.filepath;
          img.width = 308;
          $('#image-wrapper').html($(img));
          $(img).Jcrop();
        } else if (ret.notice){
          $('#image-wrapper').html($('<div class="alert alert-danger"></div>').text(ret.notice));
        }
      }
    });
  });

  var cropCoords = {};

  function showCoords (coords) {
    $.extend(cropCoords, coords)
    console.log(cropCoords);
  }

  $('img').Jcrop({
    onChange: showCoords
    });

  function crop () {

  }

  $('#crop').on('click', function(){
    $.ajax({
      url: '/crop',
      type: 'POST',
      data: cropCoords,
      success: function(ret) {
        console.log(ret);
      }
      });
  })

});
