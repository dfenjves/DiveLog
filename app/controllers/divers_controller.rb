class DiversController < ApplicationController

  def index
    respond_to do |format|
      format.json { render json: (Diver.all.collect { |diver| "#{diver.name}" }) }
      format.html { redirect_to root_path }
    end

  end

  def show
    @diver = Diver.find_by(id: params[:id])
    if !@diver
      redirect_to dives_path, :flash => { :error => "That diver does not exist" }
    end
  end
end