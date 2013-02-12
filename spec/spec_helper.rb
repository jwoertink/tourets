$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'tourets'
require 'rspec'

RSpec.configure do |c|
  c.mock_with(:rspec)
end
