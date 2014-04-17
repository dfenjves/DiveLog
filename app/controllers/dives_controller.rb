class DivesController < ApplicationController

  before_action :set_dive, only: [:show, :edit, :update, :destroy]

  def index
    if logged_in?
      @dives = current_diver.dives
    else
      redirect_to root_path, :flash => { :error => "You must be signed in to see this page" }
    end
  end

  def show
    @photo = @dive.photos.new
    @fish = Fish.new
    @diver = Diver.new
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
      if dive_params[:dive_site] == ""
        flash[:error] = "Please enter a dive site"
        render "new"
      else
        flash[:error] = "Please enter a date"
        render "new"
      end
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
      if !( !real_time?(dive_params) || @dive.update(dive_params))
        format.html { redirect_to(@dive, :notice => 'Dive was successfully updated.') }
        format.json { respond_with_bip(@dive) }
      else
        format.html { head :ok, :error => 'Something went wrong.' }
        format.json { head :ok }
      end
    end    
  end

  def real_time?(update_params)
    begin
      if update_params["time_in"]
        Time.parse(update_params["time_in"])
      end

      if update_params["time_out"]
        Time.parse(update_params["time_out"])
      end         
    rescue
      return false
    end
    return true
  end

  def destroy
    if logged_in? && dive_team_member?
      @dive.destroy
      redirect_to diver_path
    else
      redirect_to dive_path(@dive), :flash => { :error => "You can't delete someone else's dive!" }
    end
  end

  def addfish
    @fish = Fish.find_by(:name => params[:name])

    @dive = Dive.find(params[:id])
    @dive.fish << @fish if !@dive.fish.include?(@fish)
    render :json => @dive.fish
  end


  def adddiver
    @diver = Diver.find_by(name: params[:name])
    @dive = Dive.find(params[:id])
    @dive.divers << @diver if !@dive.divers.include?(@diver)
    render :json => @diver
  end

  def removediver
    @dive = Dive.find(params[:id])
    @diver = Diver.find_by(:id => params[:diver_id])
    @diverdive = DiverDive.find_by(:dive_id => @dive.id, :diver_id => @diver.id)
    if @dive.diver_dives.first == @diverdive
      render :json => { :errors => "This doesn't work"}
    else
      @diverdive.destroy
      render :json => { :head => :ok }
    end
  end

  def removefish
    @dive = Dive.find(params[:id])
    @fish = Fish.find(params[:fish_id])
    @dive_fish = DiveFish.find_by(:dive_id => @dive.id, :fish_id => @fish.id)
    @dive_fish.destroy
    render :json => { :head => :ok }
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