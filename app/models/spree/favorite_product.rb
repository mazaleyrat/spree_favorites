module Spree
  class FavoriteProduct < ActiveRecord::Base
	  belongs_to :user, class_name: Spree.user_class.name
  	belongs_to :variant, class_name: 'Spree::Variant'
  end
end
