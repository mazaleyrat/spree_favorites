Deface::Override.new(
  virtual_path: 'spree/products/show',
  name: 'add_wish_to_product',
  insert_top: "[data-hook='product_images'] #main-image",
  partial: 'spree/products/product_wish_link',
  original: '5d9b02c7f2ff6caca1abce03ee9528ba55dfc949'
)
