class PhotosController < ApplicationController
  
  def create
  	@dive =  Dive.find(params[:photo][:dive_id])
  	params[:image].each do |i|
  		@dive.photos.create!(:image => i)
  	end
  	redirect_to dive_path(@dive)
  end

end