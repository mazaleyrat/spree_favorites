module Spree::UserDecorator
  def self.prepended(base)
    base.has_many :favorite_variants, dependent: :destroy, class_name: "Spree::FavoriteVariant"
  end
end

Spree::User.prepend Spree::UserDecorator