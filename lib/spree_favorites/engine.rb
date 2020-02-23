module SpreeFavorites
  class Engine < Rails::Engine
    
    engine_name 'spree_favorites'

#  	initializer "spree_favorites.assets.precompile" do |app|
#      app.config.assets.paths << File.expand_path("../../assets/images", __FILE__)
#	    app.config.assets.precompile += %w( spree_favorites/*.svg )
#    end


#    config.autoload_paths += Dir["#{config.root}/lib"]

    config.to_prepare do
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
      Spree::Ability.register_ability(Spree::FavoritesAbility)
    end

  end
end