module Spree::VariantDecorator
  def self.prepended(base)
    base.has_many :favorites, dependent: :destroy, class_name: 'Spree::Favorite'
  end
end

Spree::Variant.prepend Spree::VariantDecorator