Spree.ready(function($) {

  $('.js-favorite-add-to-cart').on('click', function(event) {
    var variant = $(this).data('variant')
console.log(variant)
    var product = $(this).data('product-summary')
console.log(product)
    var variantId = variant.id
    var quantity = 1

    event.preventDefault()
    $(this).prop('disabled', true)
    Spree.ensureCart(function() {
      SpreeAPI.Storefront.addToCart(
        variantId,
        quantity,
        {}, // options hash - you can pass additional parameters here, your backend
        // needs to be aware of those, see API docs:
        // https://github.com/spree/spree/blob/master/api/docs/v2/storefront/index.yaml#L42
        function(response) {
          Spree.fetchCart()
          Spree.showProductAddedModal(product, variant)
        },
        function(error) {
          if (typeof error === 'string' && error !== '') {
            document.querySelector('#no-product-available .no-product-available-text').innerText = error
          }
          document.getElementById('overlay').classList.add('shown')
          document.getElementById('no-product-available').classList.add('shown')
          window.scrollTo(0, 0)
        } // failure callback for 422 and 50x errors
      ).then( function(){ $(this).prop('disabled', false) })
    })
  })

})