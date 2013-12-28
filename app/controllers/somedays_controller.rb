class SomedaysController < ApplicationController
  respond_to :json

  def index
    respond_with current_user.somedays
  end

  def create
    current_user.somedays.create
    
    respond_with :nothing
  end
end