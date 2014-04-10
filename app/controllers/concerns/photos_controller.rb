class PhotosController < ApplicationController
  
  def create
  	@photo = Photo.create(:image => params[:image], :dive_id => params[:photo][:dive_id])
  end

end