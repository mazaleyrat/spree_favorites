module Spree
  class WishlistAbility
    include CanCan::Ability

    def initialize(user)
      user ||= Spree.user_class.new
      # Anyone can add wished product to wishlist
      can :create, Spree::WishedProduct
      # You can only browse or change own wishlist product
      can [:index, :read, :update, :destroy], Spree::WishedProduct, user_id: user.id
    end

  end
end