module TouRETS
  module Utilities
    
    # Convert a key value pair into a RETS formatted query string.
    # TODO: Take values that are arrays, ranges, or hashes, and convert those properly
    def hash_to_rets_query_string(hash)
      [].tap do |str|
        hash.each_pair do |k,v|
          str << "(#{k.to_s.camelize}=#{v})"
        end
      end.join(',')
    end
    
    # This takes a hash of search parameters, and modifies 
    # the hash to have the correct key types for the current RETS server
    def map_search_params(search_params)
      new_hash = Hash[search_params.map {|k, v| [key_map[k], v] }]
    end
    
    # Giant Hash
    # TODO: OPTIMIZE!!!! ZOMG! O_o
    # Maybe break this into a YAML file that will pick which keymap to use based on the current_connection?
    # I'm thinking maybe like a dictionary lookup. Figure out what each RETS server uses.
    def key_map
      {
        :property_type => "1",
        :zip_code => "10",
        :address => "13",
        :bathrooms => "61",
        :bedrooms => "68",
        :agentcode => "143",
        :list_price => "144",
        :listing_id => "163",
        :sqft => "2361"
      }
    end
    
  end
end