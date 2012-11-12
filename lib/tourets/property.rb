module TouRETS
  class Property
    # This class searches for ResidentialProperty, Condo, SingleFamily, Rental
    # Some MLS use "1", some use :RES... Will need to decide which way is to be used.
    
    
    class << self
      
      # Returns an array of property results. 
      def where(search_params = {})
        ensure_connected!
        [].tap do |properties|
          search_params = map_search_params(search_params)
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
    
  end
end