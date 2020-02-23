module Spree
  class FavoritesAbility
    include CanCan::Ability

    def initialize(user)
      user ||= Spree.user_class.new
      # Anyone can add favorite products
      can :create, Spree::Favorite
      # You can only browse or change own wishlist product
      can [:index, :read, :update, :destroy], Spree::Favorite, user_id: user.id
    end

  end
end