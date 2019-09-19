$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require 'sss_wishlist/version'

Gem::Specification.new do |spec|
  spec.platform    = Gem::Platform::RUBY
  spec.name        = 'sss_wishlist'
  spec.version     = SssWishlist.version
  spec.summary     = 'Add a wishlist to Spree Social Sales'
  spec.description = spec.summary
  spec.required_ruby_version = '>= 2.1.0'

  spec.authors     = ["MateoLa"]
  spec.email       = ["mateo.laino@gmail.com"]
  spec.homepage    = "https://github.com/MateoLa"
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  spec.require_path  = 'lib'
  spec.requirements << 'none'

  spec.add_dependency 'spree_core', '>= 3.1.0', '< 5.0'
  spec.add_dependency 'sss'
  spec.add_dependency 'inline_svg'
  spec.add_dependency 'cancancan', '~> 2.0'

#  spec.add_development_dependency 'factory_bot', '~> 4.7'
#  spec.add_development_dependency 'ffaker'
#  spec.add_development_dependency 'rspec-rails'
#  spec.add_development_dependency 'sqlite3', '~> 1.3.6'
#  spec.add_development_dependency 'capybara'
#  spec.add_development_dependency 'poltergeist'
#  spec.add_development_dependency 'database_cleaner'
#  spec.add_development_dependency 'simplecov'
#  spec.add_development_dependency 'shoulda-matchers'
#  spec.add_development_dependency 'coffee-rails'
#  spec.add_development_dependency 'sass-rails'
#  spec.add_development_dependency 'guard-rspec'
#  spec.add_development_dependency 'pry-rails'
#  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'mysql2'
  spec.add_development_dependency 'pg', '~> 0.18'
#  spec.add_development_dependency 'appraisal'
#  spec.add_development_dependency 'puma'
end
