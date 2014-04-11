require 'spec_helper'

describe Diver do

  before :each do
    @diver = FactoryGirl.build(:diver)
  end

  describe 'basic model functions' do

    it 'can be created and successfully saved' do
      expect(@diver.save).to be_true
    end

    it 'requires a name' do
      @diver.name = ""
      expect(@diver.save).to be_false
      @diver.name = nil
      expect(@diver.save).to be_false      
    end
  end

  describe 'associations' do

    before :each do
      @dive = FactoryGirl.build(:dive)
    end

    it 'has many dives' do
      @diver.dives << @dive
      expect(@diver.dives.length).to eq(1)
    end

  end
end
