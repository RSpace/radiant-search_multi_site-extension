module SearchMultiSite
  module SearchPageExtensions
    def self.included(base)
      base.extend(ClassMethods)
      base.class_eval {
        mattr_accessor :site_page_ids
        include(InstanceMethods)
        alias_method_chain :render, :multi_site
      }
    end
    
    module ClassMethods
      
      def clear_page_ids_for_site_cache
        self.site_page_ids = {}
      end
      
    end
    
    module InstanceMethods
      
      def render_with_multi_site
        ids = page_ids_for_site(Page.current_site)
        Page.send(:with_scope, {:find => { :conditions => "pages.id IN (#{ids.join(', ')})" }}) do
          render_without_multi_site
        end
      end

      private

        def page_ids_for_site(site)
          self.site_page_ids ||= {}
          self.site_page_ids[site] ||= collect_ids(site.homepage).flatten
          self.site_page_ids[site]
        end
      
        def collect_ids(parent)
          [parent.id] + parent.children.collect { |child| collect_ids(child) }
        end

      
    end
    
  end
end