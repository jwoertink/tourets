module TouRETS
  module Utilities
    
    # Convert a key value pair into a RETS formatted query string.
    # TODO: Take values that are arrays, ranges, or hashes, and convert those properly
    def hash_to_rets_query_string(hash)
      [].tap do |str|
        hash.each_pair do |k,v|
          val = value_map(v)
          str << "(#{k.to_s.camelize}=#{val})"
        end
      end.join(',')
    end
    
    # This takes a hash of search parameters, and modifies 
    # the hash to have the correct key types for the current RETS server
    def map_search_params(search_params)
      Hash[search_params.map {|k, v| [key_map[k], v] }]
    end
    
    # Giant Hash.
    # TODO: OPTIMIZE!!!! ZOMG! O_o
    # Maybe break this into a YAML file that will pick which keymap to use based on the current_connection?
    # I'm thinking maybe like a dictionary lookup. Figure out what each RETS server uses.
    # Also good to note that there are different data types, but they all are strings. 
    # We could figure out a way to convert to Integer, or DateTime objects, etc... depending.
    def key_map
      {
        :id => "sysid",         #String
        :property_type => "1",  #String
        :acreage => "2",        #Float
        :zip_code => "10",      #String
        :address => "13",       #String
        :partial_flag => "17",  #String
        :close_date => "25",    #DateTime
        :agent_name => "26",    #String
        :annual_property_tax => "28", #Integer
        :has_dishwasher => "30",      #Boolean
        :has_disposal => "31",        #Boolean
        :has_refrigerator => "33",    #Boolean
        :dryer_hookup => "34",        #String
        :area => "37",                #String
        :association_fee => "39",     #Integer
        #1st Encumbr Assumption Desc => "43" # Like the mortgage...
        :three_quarter_baths => "60", #Integer
        :bathrooms => "61",           #Integer
        :half_baths => "62",          #Integer
        :total_baths => "63",         #Integer
        :downstairs_bath_desc => "63",#String
        :bedrooms => "68",            #Integer
        :built_desc => "72",          #String
        :carport_desc => "73",        #String
        :carports => "74",            #Integer
        :comp_days_on_market => "81", #Integer (this is nil sometimes)
        :contingency_desc => "84",    #String
        :contract_date => "85",       #DateTime
        :cooling_fuel_desc => "86",   #String
        :county => "87",              #String
        :second_bed_dim => "89",      #String
        :third_bed_dim => "90",       #String
        :fourth_bed_dim => "91",      #String
        :dining_room_dim => "92",     #String
        :family_room_dim => "93",     #String
        :fifth_bed_dim => "94",       #String
        :living_room_dim => "95",     #String
        :master_bed_dim => "96",      #String
        :fifth_bed_desc => "97",      #String
        :days_on_market => "101",     #Integer
        :entry_date => "104",         #DateTime
        :fence => "112",              #String
        :fireplaces => "113",         #Integer
        :converted_garage? => "120",  #Boolean
        :garages => "122",            #Integer
        :ground_mounted? => "125",    #Boolean
        :images => "129",             #Integer
        :internet_display => "130",   #Boolean
        :land_use => "132",           #Integer
        :last_transaction_code => "134", #String
        :last_transaction_at => "135",#DateTime
        :list_office_code => "137",   #String
        :listed_on => "138",          #DateTime
        :agentcode => "143",          #String
        :list_price => "144",         #Float
        :agent_member_id => "145",    #String
        :lot_sqft => "154",           #Integer
        :community => "155",          #String
        :listing_number => "163",     #String
        :occupancy_desc => "170",     #String
        :listing_office => "171",     #String
        :listing_office_phone => "172", #String
        :original_list_price => "173",#Float
        :parcel_number => "176",      #String
        :photo_instructions => "182", #String
        :pools => "184",              #Integer
        :property_condition => "202", #String
        :has_pool => "203",           #Boolean
        :record_deleted_at => "205",  #DateTime
        :record_deleted => "207",     #Boolean
        :buyer_broker => "211",       #String
        :elementary_school_2 => "213",#String
        :highschool => "214",         #String
        :middle_school => "215",      #String
        :year_round_school => "216",  #String
        :buyer_agentcode => "218",    #String
        :sewer => "219",              #String
        # #Loft => "231",             #Integer
        :has_spa => "236",            #Boolean
        :active_properties => "242",
        :idx_display => "1809",
        :sqft => "2361"
      }
    end
    
    # Take values like true and false, convert them to "Y" or "N". make collections into joint strings.
    def value_map(value)
      v = case value.class
      when Array
        value.join(',')
      when Range
        "#{value.first}-#{value.last}"
      when Hash
        if value.has_key?(:or)
          "|#{value[:or].join(',')}"
        elsif value.has_key?(:not)
          "~#{value[:not].join(',')}"
        end
      when TrueClass
        "Y" # TODO: figure out if this should be Y or Yes
      when FalseClass
        "N" # TODO: figure out if this should be N or No
      else
        value
      end
      v
    end
    
  end
end