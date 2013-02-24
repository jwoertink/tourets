require 'spec_helper'

describe TouRETS do
  
  describe '#establish_connection', focus: true do
    
    it 'connects to the FOO MLS' do
      TouRETS.should_receive(:establish_connection).with('FOO').and_return(true)
      TouRETS.establish_connection('FOO')
    end
    
    it 'raises an exception when no key is passed' do
      #TouRETS.establish_connection.should raise ArgumentError
    end
  end
end