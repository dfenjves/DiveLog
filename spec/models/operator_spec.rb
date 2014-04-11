require 'spec_helper'

describe Operator do

  before :each do
    @operator = FactoryGirl.build(:operator)
  end

  describe 'basic model functions' do

    it 'can be created and successfully saved' do
      expect(@operator.save).to be_true
    end
    
  end
end