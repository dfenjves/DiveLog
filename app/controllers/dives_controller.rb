class DivesController < ApplicationController
  
  before_action :set_dive, only: [:show, :edit, :update, :destroy]

  def index
    @dives = Dive.all
  end

  def show
  end

  def new
    @dive = Dive.new
  end

  def create
    @dive = Dive.new(dive_params)
    if @dive.save
      redirect_to dive_path(@dive)
    else
      render "new", :flash => { :error => "There was a problem with your submissions!" }
    end
 
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_dive
    @dive = Dive.find(params[:id])
  end

  def dive_params
    params.require(:dive).permit(:date, :depth, :temperature, :time_in, :time_out, :dive_site, :visibility, :start_air,
      :end_air, :dive_type, :dive_activity, :wetsuit, :conditions, :notes)
  end
end