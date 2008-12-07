# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class SearchMultiSiteExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/search_multi_site"
  
  def activate
    SearchPage.send :include, SearchMultiSite::SearchPageExtensions
    ActiveRecord::Base.observers << SearchMultiSite::PageObserver
  end
  
  def deactivate
  end
  
end