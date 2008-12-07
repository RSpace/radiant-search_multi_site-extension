module SearchMultiSite
  class PageObserver < ActiveRecord::Observer
    observe ::Page
    
    def after_save(page)
      SearchPage.clear_page_ids_for_site_cache
    end
  end
end