class DivesController < ApplicationController
  
  before_action :set_dive, only: [:show, :edit, :update, :destroy]

  def index
    if logged_in?
      @dives = current_diver.dives
    else
      redirect_to root_path, :flash => { :error => "You must be signed in to see this page" }
    end
    # @q = Dive.search(params[:q])
    # @dives = @q.result(distinct: true)
  end

  def show
  end

  def new
    if logged_in?
      @dive = Dive.new
    else
      redirect_to root_path, :flash => { :error => "Please sign in to log a dive" }
    end
  end

  def create
    @dive = Dive.new(dive_params)
    @diver = current_diver
    if logged_in? && @dive.save
      params[:photos]['image'].each { |p| @dive.photos.create!(:image => p, :dive_id => @dive.id) }    
      @diver.dives << @dive
      redirect_to dive_path(@dive)
    else
      render "new", :flash => { :error => "There was a problem with your submissions!" }
    end
 
  end

  def edit
  end

  def update
    @dive.update(dive_params)
    redirect_to @dive
  end

  def destroy
    @dive.destroy
    redirect_to diver_path
  end

  private

  def set_dive
    @dive = Dive.find_by(id: params[:id])
    redirect_to diver_path if @dive == nil
  end

  def dive_params
    params.require(:dive).permit(:date, :depth, :temperature, :time_in, :time_out, :dive_site, :visibility, :start_air,
      :end_air, :dive_type, :dive_activity, :wetsuit, :conditions, :notes)
  end
end