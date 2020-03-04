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

    if (variantId) { SetFavorite(variantId) }
  })


  $("#js-favorite-button").on("click", function(event){
    event.preventDefault()
    var variantId = parseInt($("#variant_id").val())
    if ( variantId ) {
      $(this).prop('disabled', true)
      if (SpreeAPI.oauthToken) { UpdateFavorites(variantId) }
      else { Spree.fetchApiTokens().then( UpdateFavorites(variantId) )}
    } else {
      var type = "secondary"
      var message = Spree.translations.no_option_selected
      PrependMessage(type, message)
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


function UpdateFavorites(varId) {  
  var aux = $.map(favorites, function(val) { return val.variant_id })
  var pos = aux.indexOf(varId)
  var Id = ""
  if ( pos>-1 ){
    Id = favorites[pos].id
    favorites.splice(pos, 1)
    method = "delete"
  } else {
    method = "post"
  }
  var url = Spree.pathFor('account/'+user_id+'/favorites/')
  if (method=="delete") { url = url + Id }
  var token = $( 'meta[name="csrf-token"]' ).attr( 'content' );
   
  $.ajax({
    url: url,
//    headers: { 'X-CSRF-Token': SpreeAPI.oauthToken },
    method: method,
    dataType: 'json',    
    data: { variant_id: varId },
    beforeSend: function ( xhr ) {
//not-working:      xhr.setRequestHeader( 'X-CSRF-Token', SpreeAPI.oauthToken );
//not-working      xhr.setRequestHeader( 'X-Spree-Token', SpreeAPI.oauthToken );      
      xhr.setRequestHeader( 'X-CSRF-Token', token );      
    },
    success: function(data) {
      if (data.favorite && data.type=="success") { favorites.push(data.favorite) }
      SetFavorite(varId)
      PrependMessage(data.type, data.message)
    }
  }).then(function() { $("#js-favorite-button").prop("disabled", false) })
  return false
}


function PrependMessage(type, message) {
  flashDiv = $('<div class="alert alert-' + type + '" role="alert" />');
  flashButton = $('<button class="close" data-dismiss="alert" data-hidden="true" />').html("&times;");
  flashSpan = $('<span />').html(message)
  $("main#content").prepend(flashDiv);
  flashDiv.append(flashButton, flashSpan).show().delay(5000).slideUp();
  window.scrollTo(0, 0)  
}


function LoadFavorites(user_id) {
  var variantId = $("#variant_id").val();  
  $.ajax({
    url: Spree.pathFor('account/'+user_id+'/favorites'),
    method: 'get',
    dataType: 'json',
    success: function(data) {
      favorites = data
      SetFavorite(variantId)
    }
  })
  return false
}


function SetFavorite(varId) {
  var aux = $.map(favorites, function(val) { return val.variant_id })
  if ( aux.indexOf(parseInt(varId))>-1 ){
    $("#js-favorite-button").addClass('wished');
  } else {
    $("#js-favorite-button").removeClass('wished');
  }
}