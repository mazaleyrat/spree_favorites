module Spree
  class FavoritesController < Spree::StoreController

    skip_before_action :verify_authenticity_token

#  def index
#    return @wished_products
#  end

    def create
      @favorite = Spree::Favorite.new(variant_id: params[:variant_id])
      @favorite.user = spree_current_user
      if @favorite.save
        message = Spree.t(:successfully_created, scope: :favorites)
        type = "success"
      else
        message = Spree.t(:validation_error, scope: :favorites)
        type = "danger"
      end
      render :json => { message: message, type: type}
    end

    def destroy
      @favorite = Spree::Favorite.where(variant_id: params[:variant_id], user: spree_current_user).first
      if @favorite.destroy
        message = Spree.t(:successfully_removed, scope: :favorites)
        type = "success"
      else
        message = Spree.t(:delete_error, scope: :favorites)
        type = "danger"
      end
      render :json => { message: message, type: type}
    end


#  def load_wishes
#    @favorites = spree_current_user.favorite_variants
#3  end

  end
end
