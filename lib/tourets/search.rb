module TouRETS
  
  class Search
    
    class << self
      
      # This works as a raw search. This give the developer a chance 
      # to customize how they want to search.
      def find(search_params = {}, &block)
        raise ArgumentError, "No block passed" unless block_given?
        TouRETS.ensure_connected!
        TouRETS.current_connection.search(search_params, &block)
      end
      
    end
    
  end
  
end