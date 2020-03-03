Deface::Override.new(
  virtual_path: 'spree/products/_gallery',
  name: 'add_favorite_to_products_gallery',
  insert_bottom: '[data-hook="product_left_part_wrap"] .product-details-single',
  partial: 'spree/products/favorite',
  original: '9f2c4ee5cd56f492b0b9b0ebef0677f25f29ced5'
)