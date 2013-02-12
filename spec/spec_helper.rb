$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'tourets'
require 'rspec'

RSpec.configure do |c|
  c.mock_with(:rspec)
  c.filter_run focus: true
  c.treat_symbols_as_metadata_keys_with_true_values = true
  
  # Be sure to add in the fixtures/config/rets_config.yml
  # This file should match the layout specified in the README
  def config_settings
    config_path = File.join(File.dirname(__FILE__), 'fixtures', 'config', 'rets_config.yml')
    File.exists?(config_path) ? YAML.load(config_path)[0] : {}
  end
end


