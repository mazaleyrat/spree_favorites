Deface::Override.new(
  virtual_path: 'spree/users/_account_sidebar',
  name: 'add_wishlist_to_account_sidebar',
  insert_after: "li#orders_tab",
  partial: 'spree/users/wishlist_tab',
  original: 'f1f0e9b7901295ea2f4dedaa53efd632aaa2d26e'
)
