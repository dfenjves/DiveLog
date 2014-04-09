class Photo < ActiveRecord::Base
	belongs_to :dive
	mount_uploader :image, ImageUploader
end
