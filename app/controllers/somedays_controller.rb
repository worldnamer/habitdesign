class SomedaysController < ApplicationController
  def index
    respond_to do |format|
      format.json do
        render json: current_user.somedays
      end
    end
  end

  def create
    someday = current_user.somedays.create

    render json: someday.to_json
  end
end