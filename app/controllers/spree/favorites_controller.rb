module Spree
  class FavoritesController < Spree::StoreController
    include Spree::ProductsHelper
    
    before_action :load_user
    skip_before_action :verify_authenticity_token

    def index
      @favorites = @user.favorites
      favorites_variants_ids = @favorites.map {|fvrt| fvrt.variant_id}      
      respond_to do |format|
        format.json { render json: favorites_variants_ids, layout: false }       
        format.html
      end
    end

    def create
      @favorite = Spree::Favorite.new(variant_id: params[:variant_id])
      @favorite.user = @user
      if @favorite.save
        message = Spree.t(:successfully_created)
        type = "success"
      else
        message = Spree.t(:validation_error)
        type = "danger"
      end
      render :json => { message: message, type: type}
    end

    def destroy
      @favorite = @user.favorites.find_by(variant_id: params[:variant_id])      
      if @favorite.destroy
        message = Spree.t(:successfully_removed)
        type = "success"
      else
        message = Spree.t(:delete_error)
        type = "danger"
      end
      render :json => { message: message, type: type}
    end

    private

    def load_user
      @user = spree_current_user if spree_current_user.present?
    end

  end
end
