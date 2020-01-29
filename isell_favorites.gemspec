$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require 'isell_favorites/version'

Gem::Specification.new do |spec|
  spec.platform    = Gem::Platform::RUBY
  spec.name        = 'isell_favorites'
  spec.version     = IsellFavorites.version
  spec.summary     = 'Add a favorites list to Isell'
  spec.description = spec.summary

  spec.author    = ["VeroLa Srl."]
  spec.email     = ["mateo.laino@gmail.com"]
  spec.homepage  = "https://github.com/MateoLa"
  spec.license   = "MIT"

  spec.required_ruby_version = '>= 2.5.0'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://github.com/MateoLa/isell_favorites"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency 'spree_core'
#  spec.add_dependency 'sss'
#  spec.add_dependency 'inline_svg'
#  spec.add_dependency 'cancancan', '~> 2.0'

end
