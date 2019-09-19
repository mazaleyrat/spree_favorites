class Spree::WishedProduct < ActiveRecord::Base

  belongs_to :user, class_name: Spree.user_class.to_s
  belongs_to :variant, class_name: 'Spree::Variant'

end
