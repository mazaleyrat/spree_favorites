var optionValues = []
var favorites = []

Spree.ready(function($) {
  if ($("#js-favorite-button").length) {
    user_id = $("#js-favorite-button").data('user-id')
    LoadFavorites(user_id)    
    optionTypeZero = $('.product-variants-variant-values-radio' + '[data-option-type-index=0]' + ':checked');
    if (optionTypeZero) UpdateOptionValues(optionTypeZero)
  }


//  Usually: variantId = $("#variant_id").val();
//  Here we can't get variant this way because the cart_form listener is too slow.
//  The listener we are adding goes to a different execution queue and finish before "#variant-id"
//  has been updated.
  $("#product-variants input[type='radio']").on("click", function(event){
    UpdateOptionValues($(this));
    var variant = TryVariant(optionValues);
    var variantId = (variant && variant.id) || ''
    if ( favorites.indexOf(parseInt(variantId))>-1 ){
      $("#js-favorite-button").addClass("wished");
    } else {
      $("#js-favorite-button").removeClass("wished");
    }
//console.log(favorites)    
  })

  $("#js-favorite-button").on("click", function(event){
    event.preventDefault()
    var variantId = parseInt($("#variant_id").val())
    if ( variantId ) {
      $(this).prop('disabled', true)
      if ( favorites.indexOf(variantId)>-1 ){
        $(this).removeClass('wished');
        favorites.splice($.inArray(variantId, favorites), 1);
        method = "delete";
      } else {
        $(this).addClass('wished');
        favorites.push(variantId);
        method = "post";
      }
      UpdateFavorites(variantId, method);
    } else {
      var type = "secondary";
      var message = Spree.translations.no_option_selected;
      PrependMessage(type, message);
    }
  })

});


function UpdateOptionValues(optionValue) {
  var index = optionValue.data('option-type-index')
  optionValues.splice(index, optionValues.length+1, parseInt(optionValue.val()))
}


function TryVariant(optVals) {
  var variants = JSON.parse($("#add-to-cart-form").attr('data-variants'));

  return variants.find(function(variant) {
    var optionValueIds = variant.option_values.map(function(ov) {
      return ov.id
    })
    return areArraysEqual(optionValueIds, optVals)
  })
}


function areArraysEqual(array1, array2) {
  return this.sortArray(array1).join(',') === this.sortArray(array2).join(',')
}


function sortArray(array) {
  return array.concat().sort(function(a, b) {
    if (a < b) return -1
    if (a > b) return 1

    return 0
  })
}


function UpdateFavorites(variant_id, method) {
  $.ajax({
    url: Spree.pathFor('variants/'+variant_id+'/favorite'),
    method: method,
//    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},    
    success: function(data) {
      // success callback function
      PrependMessage(data.type, data.message)
    }
  }).done(function() { $("#js-favorite-button").prop("disabled", false) })
  return false
}


function PrependMessage(type, message) {
  flashDiv = $('<div class="alert alert-' + type + '" role="alert" />');
  flashButton = $('<button class="close" data-dismiss="alert" data-hidden="true" />').html("&times;");
  flashSpan = $('<span />').html(message)
  $("main#content").prepend(flashDiv);
  flashDiv.append(flashButton, flashSpan).show().delay(5000).slideUp();
}

/*
function LoadFavorites(user_id) {
  $.ajax({
    url: Spree.pathFor('account/'+user_id+'/favorites'),
    method: 'get',
    success: function (data) {
      // success callback function
      console.log(data)
      favorites = data
      var variantId = $("#variant_id").val();
      if ( favorites.indexOf(parseInt(variantId))>-1 ){
        $("js-favorite-button").addClass('wished');
      } else {
        $("js-favorite-button").removeClass('wished');
      }
    }
  });
  return false
}
*/

function LoadFavorites(user_id) {
  var url = Spree.pathFor('account/'+user_id+'/favorites')
  fetch(url).then(function (response) {
    // response.json() retuns another promise so you have to wait until it will be fullfilled.
    if (response.ok) { response.json().then( function(data){ 
        favorites = data
        var variantId = $("#variant_id").val();
        if ( favorites.indexOf(parseInt(variantId))>-1 ){
          $("js-favorite-button").addClass('wished');
        } else {
          $("js-favorite-button").removeClass('wished');
        }
      })
    }
  })
}
