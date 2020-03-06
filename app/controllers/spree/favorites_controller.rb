module Spree
  class FavoritesController < Spree::StoreController
    include Spree::ProductsHelper

# This is an option to avoid tokens on create.
#    skip_before_action :verify_authenticity_token

    def index
      authorize! :index, Spree::Favorite
      @favorites = spree_current_user.favorites
      respond_to do |format|
        format.html
        format.json { render json: @favorites }        
      end      
    end

    def create
      @favorite = Spree::Favorite.new(variant_id: params[:variant_id])
      authorize! :create, @favorite     # ensures user.
      @favorite.user = spree_current_user

      if @favorite.save
        message = Spree.t(:successfully_created, scope: :favorites)
        type = "success"
      else
        message = Spree.t(:validation_error, scope: :favorites)
        type = "danger"
      end
      render json: { favorite: @favorite, message: message, type: type }
    end

    def destroy
      @favorite = Spree::Favorite.find_by_id(params[:id])
      authorize! :destroy, @favorite

      if @favorite.destroy
        message = Spree.t(:successfully_removed, scope: :favorites)
        type = "success"
        flash[:success] = message        
      else
        message = Spree.t(:delete_error, scope: :favorites)
        type = "danger"
        flash[:error] = message
      end

      respond_to do |format|
        format.html { redirect_to spree.user_favorites_path(spree_current_user) }
        format.json { render :json => { message: message, type: type} }        
      end
    end

  end
end
