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

  def destroy
    someday = Someday.find(params[:id])
    someday.destroy() if someday.user_id == current_user.id

    render nothing: true
  end
end