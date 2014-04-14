class DivesController < ApplicationController
  before_action :set_dive, only: [:show, :edit, :update, :destroy]
  autocomplete :fish, :name

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
    @photo = @dive.photos.new
    @fish = @dive.fish.new
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
      if params[:photos]
        params[:photos]['image'].each { |p| @dive.photos.create!(:image => p, :dive_id => @dive.id) }  
      end
      @diver.dives << @dive
      redirect_to dive_path(@dive)
    else
      render "new", :flash => { :error => "There was a problem with your submissions!" }
    end
 
  end

  def edit
    if !logged_in?
      redirect_to root_path, :flash => { :error => "Please log in" }
    elsif !dive_team_member?
      redirect_to diver_path, :flash => { :error => "You can't edit someone else's dive!" }
    end
  end

  def update
    respond_to do |format|
      if @dive.update_attributes(dive_params)
        format.html { redirect_to(@dive, :notice => 'Dive was successfully updated.') }
        format.json { respond_with_bip(@dive) }
      else
        format.html { render :action => "edit", :error => 'Something went wrong.' }
        format.json { respond_with_bip(@dive) }
      end
    end    
  end

  def destroy
    if logged_in? && dive_team_member?
      @dive.destroy
      redirect_to diver_path
    else
      redirect_to dive_path(@dive), :flash => { :error => "You can't delete someone else's dive!" }
    end
  end

  def add_fish
    @fish = Fish.new
  end

  private

  def dive_team_member?
    @dive.divers.include?(current_diver)
  end

  def set_dive
    @dive = Dive.find_by(id: params[:id])
    redirect_to diver_path if @dive == nil
  end

  def dive_params
    params.require(:dive).permit(:date, :depth, :temperature, :time_in, :time_out, :dive_site, :visibility, :start_air,
      :end_air, :dive_type, :dive_activity, :wetsuit, :conditions, :notes)
  end
end