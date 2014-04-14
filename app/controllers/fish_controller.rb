class FishController < ApplicationController

	def index
		@fish = Fish.all
	end

	def create
		@dive = Dive.find(params[:dive_id])
		@fish = Fish.find(params[:name])
		@dive.fish << @fish
	end

	private

	def fish_params
    params.require(:fish).permit(:name, :dive_id)
  end

end
