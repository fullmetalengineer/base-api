class UsersController < ApplicationController
  skip_before_action :authenticate, only: [:login, :create]

  def login
    result = UserService.login(params[:email].downcase, params[:password])

    render json: { success: false, error: result.error.as_sentence }, status: 401 and return unless result.success?
    render json: { success: true, payload: result.user }, status: :ok
  end

  def create
    result = UserService.create(param_as_hash)
    render json: { success: false, error: "There was a problem creating your profile" }, status: :unprocessable_entity and return unless result.success?
    render json: { success: true, payload: result.payload.profile }, status: :ok
  end

  def logout
    result = UserService.logout(@current_user)
    render json: { success: false, error: "There was a problem logging you out." }, status: :unprocessable_entity and return unless result.success?
    render json: { success: true, payload: "You have been logged out." }, status: :ok
  end

  def me
    render json: @current_user.profile, status: :ok
  end

  private

  def param_hash
    params.to_unsafe_h
  end

end
