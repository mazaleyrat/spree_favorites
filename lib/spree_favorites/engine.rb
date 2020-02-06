module SpreeFavorites
  class Engine < Rails::Engine
    
    engine_name 'spree_favorites'

#    config.autoload_paths += Dir["#{config.root}/lib"]

#    config.to_prepare do
#      dir = File.dirname(__FILE__)
#      Dir.glob([File.join(dir, "../../app/**/*_decorator.rb"), 
#               File.join(dir, "../../app/overrides/*.rb")]) do |c|
#        Rails.configuration.cache_classes ? require(c) : load(c)
#      end
#      Spree::Ability.register_ability(Spree::WishlistAbility)
#    end

  end
end