require 'ruby-rets'
require 'tourets/rails'
require 'tourets/utilities'
require 'tourets/exceptions'
require 'tourets/extensions/hash' # This should go away after Rails 4.0
require 'tourets/search'
require 'tourets/photo'
require 'tourets/property'

module TouRETS
  include Utilities
  
  class << self
    attr_accessor :current_connection
    
    # This will take the specific MLS you want to connect to
    # There must be a rets_config.yml file in the :rails_root/config directory
    # 
    def establish_connection(mls) 
      config_file = File.join(app_root, 'config', 'rets_config.yml')
      if File.exists?(config_file)
        connections = YAML.load_file(config_file)
        conn = connections.select { |conn| conn['mls'] == mls }.first
        if conn.nil?
          raise ConfigurationError, "Missing or incorrect MLS key `#{mls}`."
        else
          conn.recursive_symbolize_keys!
          conn.delete(:mls)
          self.current_connection = RETS::Client.login(conn)
        end
      else
        raise ConfigurationError, "Couldn't find Config File in #{config_file}."
      end
    end
    
    # Closes the current connection to the RETS server
    def close_connection
      current_connection.logout if current_connection?
    end
    
    def ensure_connected!
      raise ConnectionError, "You must establish a connection first." unless current_connection?
    end
    
    def current_connection?
      !current_connection.nil?
    end
    
    # The root of the application using this gem
    def app_root
      if defined?(Rails)
        ::Rails.root
      else
        Dir.pwd
      end
    end
    
  end
  
end
