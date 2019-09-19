Spree.user_class.class_eval do

  has_many :wished_products, dependent: :destroy, class_name: 'Spree::WishedProduct'

end