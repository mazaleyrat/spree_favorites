module Spree::VariantDecorator
  def self.prepended(base)
    base.has_many :favorite_variants, dependent: :destroy, class_name: 'Spree::FavoriteVariant'
  end
end

Spree::Variant.prepend Spree::VariantDecorator