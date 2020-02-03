module Spree::UserDecorator
  def self.prepended(base)
    base.has_many :favorite_products, dependent: :destroy, class_name: "Spree::FavoriteProduct"
  end
end
Spree::User.prepend Spree::UserDecorator