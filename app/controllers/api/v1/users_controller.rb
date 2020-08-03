class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: UserSerializer.new(user)
    else
      data = { errors: user.errors.full_messages.uniq }
      render json: data, status: :bad_request
    end
  end

  private
  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
