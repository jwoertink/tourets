# NOTE: This class is not really implemented yet.

module TouRETS

  # VRImage is a multiple-view, possibly-interactive image related to the :resource
  class VRImage

    class << self

      # Find the vrimage
      # Use find("1234", :id => 1) to find the photo with ID 1 in the 1234 group
      # Default it to return all of the photos.
      def find(sysid, opts={})
        limit = opts[:id] || "*"
        [].tap do |photos|
          TouRETS.current_connection.get_object(:resource => opts[:resource], :type => :VRImage, :location => false, :id => "#{sysid}:#{limit}") do |headers, content|
            photos << new(headers, content)
          end
        end
      end

    end


    def initialize(*)
    end

  end
end
