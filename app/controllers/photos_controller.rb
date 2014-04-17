class PhotosController < ApplicationController
  
  def create
  	@photo = Photo.create(photo_params)
  end

  def destroy
  	@photo = Photo.find(params[:id])
  	@photo.destroy
    head :ok
  end

  private

  def photo_params
    params.require(:photo).permit(:image, :dive_id)
  end

end