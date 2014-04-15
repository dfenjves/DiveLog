require 'spec_helper'

describe Dive do

  before :each do
    @dive = FactoryGirl.build(:dive)
  end

  describe 'basic model functions' do

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

    it 'fails save without date' do
      @dive.date = nil
      expect(@dive.save).to be_false  
    end

    it 'fails save without dive_site' do
      @dive.dive_site = ""
      expect(@dive.save).to be_false  
    end

    it 'successfully saves with blank temperature' do
      @dive.temperature = nil
      expect(@dive.save).to be_true      
    end

    it 'successfully saves with blank depth' do
      @dive.depth = nil
      expect(@dive.save).to be_true      
    end    

    it 'successfully saves with blank start_air' do
      @dive.start_air = nil
      expect(@dive.save).to be_true      
    end

    it 'successfully saves with blank end_air' do
      @dive.end_air = nil
      expect(@dive.save).to be_true      
    end

    it 'says that no notes were recorded if no notes were entered' do
      @dive.notes = nil
      @dive.save
      expect(@dive.notes).to eq("No Notes Recorded")
    end

    it 'fails save when start time is later than end time' do
      @dive.time_in = "2000-01-01 13:03:00"
      @dive.time_out = "2000-01-01 13:02:00"
      expect(@dive.save).to be_false
    end

    it 'successfully saves when start time is before end time' do
      @dive.time_in = "2000-01-01 13:03:00"
      @dive.time_out = "2000-01-01 13:04:00"
      expect(@dive.save).to be_true
    end

  end

  describe 'associations' do

    it 'has many divers' do
      @diver = FactoryGirl.build(:diver)
      @dive.divers << @diver
      expect(@dive.divers.length).to eq(1)
      expect(@dive.divers.last.name).to eq("Bob")
    end

    it 'has many fish' do
      @fish = FactoryGirl.build(:fish)
      @dive.fish << @fish
      expect(@dive.fish.length).to eq(1)
      expect(@dive.fish.last.name).to eq("Nemo")
    end

    it 'belongs to an operator' do
      @operator = FactoryGirl.build(:operator)
      @dive.operator = @operator
      expect(@dive.operator.name).to eq("Scuba Sensations")    
    end

    it 'has many photos' do
      @photo = FactoryGirl.build(:photo)
      @dive.photos << @photo
      expect(@dive.photos.length).to eq(1)
    end

  end
end




