require 'spec_helper'

describe TouRETS::Property do
  
  context 'when searching for 3 bedrooms', vcr: { cassette_name: 'properties/3_bedrooms' } do
    
    subject { @properties.collect(&:bedrooms) }
    
    before do
      @properties = TouRETS::Property.where(bedrooms: 3)
    end
    
    after do
      TouRETS.close_connection
    end
    
    it 'returns properties with 3 bedrooms' do
      expect(subject).to include(3)
    end
    
    it 'excludes properties more than 3 bedrooms' do
      expect(subject).to_not include(4)
    end
    
    it 'excludes properties less than 3 bedrooms' do
      expect(subject).to_not include(2)
    end
  end
  
end