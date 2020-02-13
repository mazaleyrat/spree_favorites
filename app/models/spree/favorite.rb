module Spree
  class Favorite < ActiveRecord::Base
	  belongs_to :user, class_name: Spree.user_class.name
  	belongs_to :variant, class_name: 'Spree::Variant'

  	validates :user, :variant, presence: true
  	validates :user, uniqueness: { scope: :variant }
  end
end
