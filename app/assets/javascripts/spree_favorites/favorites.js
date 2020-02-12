Spree.routes.favorite = function(id) { return Spree.pathFor('variants/' + id + '/favorite') }


Spree.ready(function($) {

//  Initialize_Favorites();

  $('#js-favorite-link').on('click', function(event){
    event.preventDefault();
    variant = parseInt($('#variant_id').val());
    url = Spree.routes.favorite(variant);

    if ( variant ){
      $(this).hasClass('wished') ? $(this).removeClass('wished') : $(this).addClass('wished');
    }

//      $('#js-favorite-link').addClass('wished');
//      favorites.push(parseInt(variant_id));
//      $('#js-favorite-link').removeClass('wished');
//      favorites.splice(favorites.indexOf(parseInt(variant_id)),1);


    Update_Favorites(variant);
  });
});





function Initialize_Favorites (){
  variant_id = $('#variant_id').val();
console.log(favorites, variant_id);
  if ( favorites.indexOf(parseInt(variant_id)) > -1 ){
    $('#js-favorites-link').addClass('wished');
  } 
}


function Update_Favorites(variant){
  data = "";
/*  if (method == "post") { 
    url = "/variants/favorites";
    data = "variant_id=" + variant
  } else { url = "/variants/favorites/" + variant }
*/
  $.ajax({
    url: Spree.routes.favorite(variant),
    method: "post",
//    data: data,
    success: function (data, status, xhr) {
      // success callback function
      PrependMessage(data.type, data.message)
    }
  });
  return false
}

function PrependMessage(type, message){
  flashDiv = $('<div class="alert alert-' + type + '" />');
  flashButton = $('<button class="close" data-dismiss="alert" data-hidden="true" />').html("&times;");
  flashSpan = $('<span />').html(message)
  $("main#content").prepend(flashDiv);
  flashDiv.append(flashButton, flashSpan).show().delay(5000).slideUp();
}