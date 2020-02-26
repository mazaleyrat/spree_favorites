module Spree
  module Admin
    class FavoritesController < Spree::Admin::BaseController

      before_action :load_user

      respond_to :html

      def index
        per_page = params[:per_page] || Spree::Config[:admin_products_per_page]
        @favorites = @user.favorites.page(params[:page]).per(per_page)
      end

      def destroy
        @favorite = Spree::Favorite.find_by_id(params[:id])
        if @favorite.destroy
          flash[:success] = Spree.t(:successfully_removed)
        else
          flash[:error] = Spree.t(:delete_error)
        end
        respond_to do |format|
          format.html { redirect_back(fallback_location: spree.admin_path) }
          format.js   { render_js_for_destroy }
        end      
      end

      private

      def load_user
        @user = Spree.user_class.find_by_id(params[:user_id])
        unless @user
          flash[:error] = Spree.t(:user_not_found)
          redirect_to admin_path
        end
      end

    end
  end
end
