require 'spec_helper'

describe Photo do

  include CarrierWave::Test::Matchers

  describe 'photos' do

    before do
      @diver = FactoryGirl.build(:diver)
      ImageUploader.enable_processing = true
      @uploader = ImageUploader.new(@diver, :photo)
      @uploader.store!(File.open("#{Rails.root}/spec/images/fish.jpg"))
    end

    after do
      ImageUploader.enable_processing = false
      @uploader.remove!
    end

    it "should scale down an image to be no larger than 150 by 150 pixels" do
      @uploader.thumb.should be_no_larger_than(150, 150)
    end

  end
end
