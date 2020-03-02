Spree::Core::Engine.add_routes do

  resources :users, only: [], :path => 'account' do
	  resources :favorites, only: [:index, :create, :destroy]
  end

  namespace :admin, path: Spree.admin_path do
    resources :users do
      resources :favorites, only: [:index, :destroy]
    end
  end

end