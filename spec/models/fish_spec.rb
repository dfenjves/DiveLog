require 'spec_helper'

describe Fish do

  before :each do
    @fish = FactoryGirl.build(:fish)
  end

  describe 'basic model functions' do

    it 'can be created and successfully saved' do
      expect(@fish.save).to be_true
    end
    
  end
end
