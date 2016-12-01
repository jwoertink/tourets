module TouRETS
  class Connection
    attr_accessor :settings

    def initialize(mls, settings)
      key = settings.find { |conn| conn['mls'] == mls }
      raise TouRETS::ConfigurationError, "Missing or incorrect MLS key `#{mls}`." if key.nil?
      clean_setting_keys(settings)
      connect!
    end

    private

    def clean_setting_keys(settings)
      settings.recursive_symbolize_keys!
      settings.delete(:mls)
      self.settings = settings
    end

    def connect!
      RETS::Client.login(settings)
    end
  end
end
