module TouRETS
  
  class Search
    
    class << self
      
      def find(search_params = {}, &block)
        raise ArgumentError, "No block passed" unless block_given?
        begin
          TouRETS.current_connection.search(search_params, &block)
        rescue "You must establish a connection first."
          
        end
      end
      
    end
    
  end
  
end