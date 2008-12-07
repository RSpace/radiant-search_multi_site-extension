namespace :radiant do
  namespace :extensions do
    namespace :search_multi_site do
      
      desc "Runs the migration of the Search Multi Site extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          SearchMultiSiteExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          SearchMultiSiteExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Search Multi Site to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[SearchMultiSiteExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(SearchMultiSiteExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
