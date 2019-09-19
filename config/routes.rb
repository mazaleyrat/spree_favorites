Spree::Core::Engine.add_routes do

  resource :account, controller: 'users' do
    resources :wished_products
  end

#  resources :wishlists
#  resources :wished_products, only: [:create, :update, :destroy]
#  get '/wishlist' => 'wishlists#default', as: 'default_wishlist'

  namespace :admin, path: Spree.admin_path do
    resources :users do
      resources :wished_products
    end
  end

end