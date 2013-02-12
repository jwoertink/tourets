require 'vcr'
require 'webmock'

VCR.configure do |config|
  config.cassette_library_dir = File.expand_path('../../fixtures/vcr_cassettes', __FILE__)
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.ignore_localhost = true
  config.default_cassette_options = { record: :none }

  config.filter_sensitive_data('<RETS_MLS>') { config_settings['mls'] }
  config.filter_sensitive_data('<RETS_URL>') { config_settings['url'] }
  config.filter_sensitive_data('<RETS_USERNAME>') { config_settings['username'] }
  config.filter_sensitive_data('<RETS_PASSWORD>') { config_settings['password'] }
  config.filter_sensitive_data('<RETS_USERAGENT>') { config_settings['useragent']['name'] }

  config.filter_sensitive_data('<USER_AGENT>') do |interaction|
    interaction.request.headers['User-Agent'].first
  end
  
end

WebMock.disable_net_connect!(allow_localhost: true)
