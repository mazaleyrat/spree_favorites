Deface::Override.new(
  virtual_path: 'spree/products/show',
  name: 'add_favorite_to_product_show',
  insert_top: "[data-hook='product_images'] #main-image",
  partial: 'spree/products/variant_favorite',
)
