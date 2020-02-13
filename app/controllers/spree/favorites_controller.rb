module Spree
  class FavoritesController < Spree::StoreController

    skip_before_action :verify_authenticity_token
    before_action :load_variant

#  def index
#    return @wished_products
#  end

    def create
      if @variant
        @favorite = Spree::Favorite.new(variant_id: @variant)
        @favorite.user = spree_current_user
        if @favorite.save
          message = Spree.t(:successfully_created, scope: :favorites)
          type = "success"
        else
          message = Spree.t(:not_saved, scope: :favorites)
          type = "danger"
        end
      else
        message = Spree.t(:no_option_selected, scope: :favorites)
        type = "secondary"
      end      
      render :json => { message: message, type: type}
    end

#  def destroy
#    variant_id = params[:id]
#    @wished_product = @wished_products.where(variant_id: variant_id).first
#    if @wished_product.destroy
#      msg = t(:removed_from_wishlist, scope: :wishlist)
#      type = "success"
#    else
#      msg = t(:error, scope: :wishlist)
#      type = "error"
#    end
#    render :json => { msg: msg, type: type}
#  end

    private

    def load_variant
      if params[:variant_id]
        @variant = number_or_nil(params[:variant_id])
      end
    end

    def number_or_nil(string)
      num = string.to_i
      num if num.to_s == string
    end 


#  def load_wishes
#    @favorites = spree_current_user.favorite_variants
#3  end

  end
end
