$(document).ready(function() {

  $('#image-field').on('change', function(){
    $(this).closest('form').ajaxSubmit({
      success: function(ret){
        console.log(ret);
        if (ret.result){
          var img = new Image();
          img.src = ret.filepath;
          img.width = 308;
          $(img).appendTo($('#image-wrapper'));
          $(img).Jcrop();
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
