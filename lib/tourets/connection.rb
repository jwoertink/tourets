module TouRETS
  class Connection
    attr_accessor :settings
  
    # mls : String, settings : Array(Hash(String, String | Symbol | Hash(String, String)))
    def initialize(mls, settings)
      config = settings.find { |conn| conn['mls'] == mls }
      raise TouRETS::ConfigurationError, "Missing or incorrect MLS key `#{mls}`." if config.nil?
      clean_setting_keys(config)
      connect!
    end

    private

    def clean_setting_keys(config)
      config.recursive_symbolize_keys!
      config.delete(:mls)
      self.settings = config
    end

    def connect!
      RETS::Client.login(settings)
    end
  end
end
