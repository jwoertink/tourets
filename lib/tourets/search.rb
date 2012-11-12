module TouRETS
  
  class Search
    
    class << self
      
      def find(search_params = {}, &block)
        raise ArgumentError, "No block passed" unless block_given?
        current_connection.search(search_params, &block)
      end
      
    end
    
  end
  
end