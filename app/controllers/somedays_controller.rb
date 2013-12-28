class SomedaysController < ApplicationController
  respond_to :json

  def index
    respond_with current_user.somedays
  end
end