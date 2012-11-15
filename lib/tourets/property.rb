module TouRETS
  class Property
    include Utilities
    extend Utilities
    
    SEARCH_DEFAULTS = {:active_properties => "ER,EA,C", :idx_display => "Y", :internet_display => "Y"}
    
    # This class searches for ResidentialProperty, Condo, SingleFamily, Rental
    # Some MLS use "1", some use :RES... Will need to decide which way is to be used.
    class << self
      
      # Returns an array of all of the properties
      # Property.all
      def all
        TouRETS.ensure_connected!
        [].tap do |properties|
          search_params = map_search_params(SEARCH_DEFAULTS)
          Search.find(:search_type => :Property, :class => "1", :query => hash_to_rets_query_string(search_params)) do |property|
            properties << self.new(property)
          end
        end
      end
      
      # Returns an array of property results.
      # Property.where(:bedrooms => 7, :bathrooms => 4, :list_price => 200000..300000)
      # Property.where(:property_type => {:not => ['CONDO', 'TOWNHOME']}, :area => {:or => ['South West', 'North West']})
      # Property.where(:area => ['South West', 'North West']) # This is like 'AND'
      def where(search_params = {})
        TouRETS.ensure_connected!
        [].tap do |properties|
          search_params = map_search_params(SEARCH_DEFAULTS.merge(search_params))
          Search.find(:search_type => :Property, :class => "1", :query => hash_to_rets_query_string(search_params)) do |property|
            properties << self.new(property)
          end
        end
      end
      
      # # Propert.where(:bedrooms => 3).limit(10) #not implemented
      # def limit(limit_number = 5000)
      #   {:limit => limit_number}
      #   self
      # end
      # 
      # # Property.where(:bedrooms => 3).count #not implemented
      # def count
      #   {:count_mode => :only}
      #   self
      # end
      # 
      # # Property.select(['SystemName', 'LongName']).where(:bedrooms => 3) #not implemented
      # # select is to limit which fields actually get returned. This could help with mapping
      # def select(fields=[])
      #   {:select => fields}
      #   self
      # end
      
    end
    
    attr_accessor :attributes
    
    def initialize(args = {})
      self.attributes = args
    end
    
    # Return an array of the photo objects that belong to a particular property
    def photos
      @photos ||= grab_photos
    end
    
    def method_missing(method_name, *args, &block)
      val = attributes[key_map[method_name.to_sym]]
      if val.nil?
        super
      else
        return val
      end
    end
    
    private
    
      def grab_photos
        [].tap do |pics|
          pics << TouRETS::Photo.find(attributes['sysid'], :resource => :Property)
        end.flatten
      end
    
  end
end