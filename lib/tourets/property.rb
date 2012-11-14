module TouRETS
  class Property
    include Utilities
    extend Utilities
    
    SEARCH_DEFAULTS = {:active_properties => "ER,EA,C", :idx_display => "Y", :internet_display => "Y"}
    
    # This class searches for ResidentialProperty, Condo, SingleFamily, Rental
    # Some MLS use "1", some use :RES... Will need to decide which way is to be used.
    class << self
      # Returns an array of property results. 
      def where(search_params = {})
        TouRETS.ensure_connected!
        [].tap do |properties|
          search_params = map_search_params(SEARCH_DEFAULTS.merge(search_params))
          Search.find(:search_type => :Property, :class => "1", :query => hash_to_rets_query_string(search_params)) do |property|
            properties << self.new(property)
          end
        end
      end
      
    end
    
    attr_accessor :attributes
    
    def initialize(args = {})
      self.attributes = args
    end
    
    # Return an array of the photo objects that belong to a particular property
    def photos
      []
    end
    
    def method_missing(method_name, *args, &block)
      val = attributes[key_map[method_name.to_sym]]
      if val.nil?
        super
      else
        return val
      end
    end
    
  end
end