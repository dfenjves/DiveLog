require 'spec_helper'

describe Dive do

  describe 'basic model functions' do

    before :each do
      @dive = FactoryGirl.build(:dive)
    end

    it 'can be created and successfully saved' do
      expect(@dive.save).to be_true
    end

    it 'fails save with an non-integer depth' do
      @dive.depth = "a billion meters"
      expect(@dive.save).to be_false
      @dive.depth = 1.2
      expect(@dive.save).to be_false    
    end

    it 'fails save with an non-integer temperature' do  
      @dive.temperature = "super cold"
      expect(@dive.save).to be_false
      @dive.temperature = 1.2
      expect(@dive.save).to be_false
    end

    it 'fails save with non-number start_air' do
      @dive.start_air = "full tank woohoo!"
      expect(@dive.save).to be_false    
    end

    it 'fails save with non-number end_air' do
      @dive.end_air = "no more oxygen helpppppp!"
      expect(@dive.save).to be_false    
    end

    it 'fails save without time_in' do
      @dive.time_in = ""
      expect(@dive.save).to be_false  
    end

    it 'fails save without time_out' do
      @dive.time_out = ""
      expect(@dive.save).to be_false  
    end

    it 'fails save without date' do
      @dive.date = nil
      expect(@dive.save).to be_false  
    end

    it 'fails save without dive_site' do
      @dive.dive_site = ""
      expect(@dive.save).to be_false  
    end

    it 'can return total time of dive in minutes' do
      expect(@dive.total_time_in_minutes).to eq(2)
    end

    it 'says that no notes were recorded if no notes were entered' do
      @dive.notes = ""
      @dive.save
      expect(@dive.notes).to eq("No Notes Recorded")
    end
  end

  describe 'associations' do

    before :each do
      @dive = FactoryGirl.build(:dive)
      @diver = FactoryGirl.build(:diver)
      @fish = FactoryGirl.build(:fish)
      @operator = FactoryGirl.build(:operator)
      @photo = FactoryGirl.build(:photo)
    end    

    it 'has many divers' do
      @dive.divers << @diver
      expect(@dive.divers.length).to eq(1)
      expect(@dive.divers.last.name).to eq("Bob")
    end

    it 'has many fish' do
      @dive.fish << @fish
      expect(@dive.fish.length).to eq(1)
      expect(@dive.fish.last.name).to eq("Nemo")
    end

    it 'belongs to an operator' do
      @dive.operator = @operator
      expect(@dive.operator.name).to eq("Scuba Sensations")    
    end

    it 'has many photos' do
      @dive.photos << @photo
      expect(@dive.photos.length).to eq(1)
    end

  end
end




