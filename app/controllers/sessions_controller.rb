class SessionsController < ApplicationController
  def create
    diver = Diver.from_omniauth(env["omniauth.auth"])
    session[:diver_id] = diver.id
    redirect_to root_url
  end

  def destroy
    session[:diver_id] = nil
    redirect_to root_url
  end
end