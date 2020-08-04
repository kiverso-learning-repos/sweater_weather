class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: login_params[:email])
    if user && user.authenticate(login_params[:password])
      session[:user_id] = user.id
      render json: UserSerializer.new(user)
    else
      error = { errors: ['Invalid email or password.'] }
      render json: error, status: :bad_request
    end
  end

  private
  def login_params
    params.require(:session).permit(:email, :password)
  end
end
