class Api::V1::TrailsController < ApplicationController
  def index
    trails = TrailsFacade.new(trail_params[:location])
  end

  private
  def trail_params
    params.permit(:location)
  end
end
