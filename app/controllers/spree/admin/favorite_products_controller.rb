module Spree
  module Admin
    class WishedProductsController < Spree::Admin::BaseController

      before_action :load_user

      respond_to :html

      def index
        per_page = params[:per_page] || Spree::Config[:admin_products_per_page]
        @wished_products = @user.wished_products.page(params[:page]).per(per_page)
      end

      def destroy
        @wished_product = Spree::WishedProduct.find_by_id(params[:id])
        if @wished_product.destroy
          flash[:success] = t(:removed_from_wishlist, scope: :wishlist)
        else
          flash[:error] = t(:error, scope: :wishlist)
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
