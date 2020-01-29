$(document).ready(function(){

  var radios = $("#product-variants input[type='radio']");

  if (radios.length > 0) {
    radios.click(function (event) {
      variant_id = $('#product-variants input[type=radio]:checked').val();
      if ( wished_variants.indexOf(parseInt(variant_id)) == -1 ){
        $('#wish_link').removeClass('wished');
      } else {
        $('#wish_link').addClass('wished');
      }
    })
  }

  $('#wish_link').on('click', function(event){
    event.preventDefault();

    var method = "";
    variant_id = $('#variant_id').val();
    selected_variant_id = $('#product-variants input[type=radio]:checked').val();
    if (selected_variant_id){ variant_id = selected_variant_id; }

    if ( wished_variants.indexOf(parseInt(variant_id)) == -1 ){
      $('#wish_link').addClass('wished');
      wished_variants.push(parseInt(variant_id));
      method = "post";
    } else {
      $('#wish_link').removeClass('wished');
      wished_variants.splice(wished_variants.indexOf(parseInt(variant_id)),1);
      method = "delete";
    }

    Update_Wished_Products(method, variant_id);
  });
});


function Initialize_Wishes(){
  variant_id = $('#product-variants input[type=radio]:checked').val();
console.log(wished_variants, variant_id);
  if ( wished_variants.indexOf(parseInt(variant_id)) > -1 ){
    $('#wish_link').addClass('wished');
  } 
}


function Update_Wished_Products(method, variant){
  url = "";
  data = "";
  if (method == "post") { 
    url = "/account/wished_products";
    data = "variant_id=" + variant
  } else { url = "/account/wished_products/" + variant }

  $.ajax({
    url: url,
    method: method,
    data: data,
    success: function (data, status, xhr) {
      // success callback function
      flashDiv = $('<div class="alert alert-' + data.type + '" />');
      $('#content').prepend(flashDiv);
      flashDiv.html(data.msg).show().delay(5000).slideUp()
    }
  });
  return false
}
