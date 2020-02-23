module Spree::ProductsControllerDecorator
  def self.prepended(base)
      base.before_action :store_location_to_return
  end

  def store_location_to_return
  	return if spree_current_user
  	store_location
  end
end

Spree::ProductsController.prepend Spree::ProductsControllerDecorator
