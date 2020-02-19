Spree.routes.favorite = function(id) { return Spree.pathFor('variants/' + id + '/favorite') }


Spree.ready(function($) {
  optionValues = [];
  optionTypeZero = $('.product-variants-variant-values-radio' + 
                    '[data-option-type-index=0]' + ':checked');
  UpdateOptionValues(optionTypeZero);


//  Usually: variant = parseInt($("#variant_id").val());
//  Here we can't get variant this way because the cart_form listener is too slow.
//  The listener we are adding goes to a different execution queue and finish before "#variant-id"
//  has been updated.

  $("#product-variants input[type='radio']").on("click", function(event){
    UpdateOptionValues($(this));
    var variant = TryVariant(optionValues);
    var variantId = (variant && variant.id) || ''
    if ( favorites.indexOf(parseInt(variantId))>-1 ){
      $("#js-favorite-link").addClass("wished");
    } else {
      $("#js-favorite-link").removeClass("wished");
    }
  })

  $("#js-favorite-link").on("click", function(event){
    event.preventDefault();
    variant = parseInt($("#variant_id").val());
    if ( variant ) {
      if ( $(this).hasClass('wished') ) {
        $(this).removeClass('wished');
        favorites.splice($.inArray(variant, favorites), 1);
        method = "delete";
      } else {
        $(this).addClass('wished');
        favorites.push(variant);
        method = "post";
      }
      Update_Favorites(variant, method);
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


function Update_Favorites(variant, method){
  $.ajax({
    url: Spree.routes.favorite(variant),
    method: method,
    success: function (data, status, xhr) {
      // success callback function
      PrependMessage(data.type, data.message)
    }
  });
  return false
}


function PrependMessage(type, message){
  flashDiv = $('<div class="alert alert-' + type + '" role="alert" />');
  flashButton = $('<button class="close" data-dismiss="alert" data-hidden="true" />').html("&times;");
  flashSpan = $('<span />').html(message)
  $("main#content").prepend(flashDiv);
  flashDiv.append(flashButton, flashSpan).show().delay(5000).slideUp();
}