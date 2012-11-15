module TouRETS
  class Photo
    
    class << self
      
      # Find the photo 
      # Use find("1234", :id => 1) to find the photo with ID 1 in the 1234 group
      # Default it to return all of the photos.
      def find(sysid, opts={})
        limit = opts[:id] || "*"
        [].tap do |photos|
          TouRETS.current_connection.get_object(:resource => opts[:resource], :type => :Photo, :location => false, :id => "#{sysid}:#{limit}") do |headers, content|
            photos << new(headers, content)
          end
        end
      end
      
    end

    attr_accessor :id, :resource_id, :content_type, :content
    
    # id is the ID of the photo
    # resource_id is the ID of the resource it belongs to. Properties will probably be sysid everytime
    # content_type is the Image content_type
    # content is the Binary string that can be written to a file to display the image.
    def initialize(headers, content)
      self.id = headers["object-id"]
      self.resource_id = headers["content-id"]
      self.content_type = headers["content-type"]
      self.content = content
    end
    
    # Use this method to get the binary string to write to a file.
    # Sometimes the string will contin ASCII-8BIT characters.
    # Forcing to UTF-8 will make it write to a file easier.
    def image
      content.to_s.force_encoding("UTF-8")
    end
    
    # Returns a filename based on the resource_id and id of the photo
    # should have proper extension on it.
    def filename
      ext = case content_type
      when /jpeg$/, /jpg$/ then "jpg"
      when /png$/ then "png"
      when /gif$/ then "gif"
      else "jpg"
      end
      "#{resource_id}-#{id}.#{ext}"
    end
    
  end
end