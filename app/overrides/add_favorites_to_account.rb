Deface::Override.new(
  virtual_path: "spree/users/show",
  name: "add_favorites_to_account",
  insert_before: "div.account-page>div>.col-lg-8",
  partial: "spree/users/favorites",
)
