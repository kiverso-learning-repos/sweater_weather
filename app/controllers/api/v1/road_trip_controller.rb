class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: road_trip_params[:api_key])
    if user
      if road_trip_params[:destination].present? && road_trip_params[:origin].present?
        begin
        road_trip = RoadTripFacade.new(road_trip_params[:origin], road_trip_params[:destination])
        rescue NoMethodError
          return render json: {errors: ["Looks like there was a problem finding these locations."]}, status: :bad_request 
        end
        render json: RoadTripSerializer.new(road_trip)
      else render json: {errors: ['Origin and destination are required']}, status: :bad_request 
      end
    else
      render json: {errors: ['Invalid API key']}, status: :unauthorized
    end
  end

  private
  def road_trip_params
    params.permit(:origin, :destination, :api_key)
  end
end
