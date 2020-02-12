Deface::Override.new(
  virtual_path: 'spree/products/_gallery',
  name: 'add_favorite_to_products_gallery',
  insert_bottom: '[data-hook="product_left_part_wrap"].product-details-images',
  partial: 'spree/products/favorite',
)
