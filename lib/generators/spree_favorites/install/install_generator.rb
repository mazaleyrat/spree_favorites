module SpreeFavorites
  module Generators
    class InstallGenerator < Rails::Generators::Base
      class_option :auto_run_migrations, type: :boolean, default: false

      #Needed by copy_views
      source_root SpreeFavorites::Engine.root.join('app')

      def add_migrations
        run 'rake railties:install:migrations FROM=spree_favorites'
      end

      def run_migrations
        run_migrations = options[:auto_run_migrations] || ['', 'y', 'Y'].include?(ask 'Would you like to run the migrations now? [Y/n]')
        if run_migrations
          run 'bundle exec rake db:migrate'
        else
          puts 'Skipping rake db:migrate, don\'t forget to run it!'
        end
      end

      def add_assets_to_spree
        # "Injecting to File" avoids the need to override layouts
        # adding scripts or stylesheets tags lines.
        inject_into_file 'vendor/assets/javascripts/spree/frontend/all.js', "\n//= require spree_favorites/frontend", after: "spree/frontend", verbose: true
        inject_into_file 'vendor/assets/stylesheets/spree/frontend/all.css', "\n *= require spree_favorites/frontend", after: "spree/frontend", verbose: true
        inject_into_file 'vendor/assets/stylesheets/spree/backend/all.css', "\n *= require spree_favorites/backend", after: "spree/backend", verbose: true
      end

      def copy_views
        dirs_to_copy = ['shared']
        dirs_to_copy.each do |dir|
          orig = 'views/spree/' + dir
          dest = './app/views/spree/' + dir
          directory orig, dest, force: true
        end
#        copy_file 'spree/shared/_translations.html.erb', 'app/views/spree/shared/_translations.html.erb'        
      end

    end
  end
end