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
        :initial_encumber_desc => "43",#String
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
        :living_area_size => "237",   #Integer
        :listing_status => "242",     #String
        :street_name => "243",        #String
        :street_number => "244",      #String
        :subdivision_name => "247",   #String
        :style_desc => "257",         #String
        :unit_number => "258",        #String
        :laundry_location => "260",   #String
        :water_desc => "261",         #String
        :year_built => "264",         #Integer
        :zoning => "266",             #String
        :property_desc => "268",      #String
        :garage_desc => "269",        #String
        :roof_desc => "270",          #String
        :lot_desc => "271",           #String
        :spa_desc => "272",           #String
        :pool_desc => "273",          #String
        :directions => "274",         #String
        :dining_room_desc => "276",   #String
        :family_room_desc => "277",   #String
        :kitchen_desc => "278",       #String
        :living_room_desc => "279",   #String
        :master_bath_desc => "280",   #String
        :master_bedroom_desc => "281",#String
        :bedroom_2_desc => "282",     #String
        :bedroom_3_desc => "283",     #String
        :bedroom_4_desc => "284",     #String
        :oven_desc => "289",          #String
        :other_appliance_desc => "290", #String
        :construction_desc => "291",  #String
        :interior_desc => "292",      #String
        :flooring_desc => "293",      #String
        :fireplace_desc => "294",     #String
        :fence_type => "295",         #String
        :equestrian_desc => "296",    #String
        :direction_house_faces => "297", #String
        :misc_desc => "298",          #String
        :exterior_desc => "299",
        :landscape_desc => "300",
        :heating_desc => "301",
        :heating_fuel_desc => "302",
        :cooling_system => "303",
        :utility_info => "304",
        :energy_desc => "305",
        :estimated_closing_date => "1736",  #DateTime
        :original_price_sqft => "1740",     #Integer
        :idx_display => "1809",             #String
        :vr_tour_link => "2139",            #String
        :last_image_trans_date => "2238",   #DateTime
        :sqft => "2361",                    #Integer
        :xp_unit_number => "2363",
        :short_sale? => "2369",             #Boolean
        :elementary_school =>"2377",
        :total_possible_bedrooms => "2379",
        :days_list_to_close => "2381",
        :unit_num => "2386",
        :ammenities_desc => "2388",
        :bath_downstairs? => "2392",        #Boolean
        :bedroom_downstairs? => "2394",     #Boolean
        :building_desc => "2414",
        :fireplace_location => "2422",
        :foreclosure_commened => "2424",    #String
        :furnishings_desc => "2426",
        :has_great_room? => "2428",         #Boolean
        :great_room_dim => "2430",
        :great_room_desc => "2432",
        :parking_desc => "2438",
        :washer_included? => "2440",
        :dryer_included? => "2442",
        :house_views => "2450",
        :subtype => "2452",
        :den_dim => "2511",
        :unit_desc => "2543",
        :repo => "2660",          #String
        :has_public_address => "2858", #Boolean
        :commentary? => "2859",     #Boolean
        :avm? => "2860",         #Boolean
        :public_address => "2861",
        :auction_date => "2878", #DateTime
        :auction_type => "2879"
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