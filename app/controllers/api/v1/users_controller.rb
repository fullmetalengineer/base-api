# frozen_string_literal: true

module Api
  module V1
    # Handles endpoints related to users
    class UsersController < Api::V1::ApplicationController
      skip_before_action :authenticate, only: %i[login create]

      def login
        result = AppServices::AuthService.login(params[:email], params[:password])
        render json: { error: 'User not authenticated' }, status: 401 and return unless result.success?

        render json: { success: true, payload: UserBlueprint.render_as_hash(result.payload, view: :login) }, status: :ok
      end

      def logout
        result = AppServices::AuthService.logout(@current_user)
        unless result.success?
          render json: { error: 'There was a problem logging out' }, status: :unprocessable_entity and return
        end

        render json: { success: 'You have been logged out' }, status: :ok
      end

      def me
        render json: UserBlueprint.render(@current_user, view: :normal), status: :ok
      end
    end
  end
end
