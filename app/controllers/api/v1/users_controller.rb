# frozen_string_literal: true

# Handles endpoints related to users
class Api::V1::UsersController < Api::V1::ApplicationController
  skip_before_action :authenticate, only: %i[login create]

  def login
    result = AppServices::AuthService.login(params[:email], params[:password])
    render json: { error: 'User not authenticated' }, status: 401 and return unless result.success?

    render json: result.payload.profile, status: :ok
  end

  def logout
    result = AppServices::AuthService.logout(@current_user)

    unless result.success?
      render json: { error: 'There was a problem logging out' }, status: :unprocessable_entity and return
    end

    render json: { success: 'You have been logged out' }, status: :ok
  end

  def me
    render json: @current_user.profile, status: :ok
  end
end
