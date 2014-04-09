class DiversController < ApplicationController
  def show
    @diver = Diver.find_by(id: params[:id])
    if !@diver
      redirect_to dives_path, :flash => { :error => "That diver does not exist" }
    end
  end
end