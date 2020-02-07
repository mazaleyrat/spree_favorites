class Spree::FavoriteVariantsController < Spree::StoreController

  before_action :load_favorites

  def index
    return @wished_products
  end

  def create
    @wished_product = Spree::WishedProduct.new(variant_id: params[:variant_id])
    @wished_product.user = spree_current_user

    if @wished_product.save!
      msg = t(:added_to_wishlist, scope: :wishlist)
      type = "success"
    else
      msg = t(:error, scope: :wishlist)
      type = "error"
    end
    render :json => { msg: msg, type: type}
  end

  def destroy
    variant_id = params[:id]
    @wished_product = @wished_products.where(variant_id: variant_id).first
    if @wished_product.destroy
      msg = t(:removed_from_wishlist, scope: :wishlist)
      type = "success"
    else
      msg = t(:error, scope: :wishlist)
      type = "error"
    end
    render :json => { msg: msg, type: type}
  end

  private

  def load_wishes
    @favorites = spree_current_user.favorite_variants
  end

end
