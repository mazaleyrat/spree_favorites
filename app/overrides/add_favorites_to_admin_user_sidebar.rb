Deface::Override.new(
  virtual_path: 'spree/admin/users/_sidebar',
  name: 'add_favorites_to_admin_user_sidebar',
  insert_bottom: "[data-hook='admin_user_tab_options']",
  partial: 'spree/admin/users/link_to_favorites',
)
