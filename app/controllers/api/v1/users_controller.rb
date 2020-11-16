# frozen_string_literal: true

module Api
  module V1
    # Handles endpoints related to users
    class UsersController < Api::V1::ApplicationController
      skip_before_action :authenticate, only: %i[login create]

      def login
        result = BaseApi::Auth.login(params[:email], params[:password])
        render_error(errors: 'User not authenticated', status: 401) and return unless result.success?

        payload = UserBlueprint.render_as_hash(result.payload, view: :login)
        render_success(payload: payload, status: :ok)
      end

      def logout
        result = BaseApi::Auth.logout(@current_user)
        render_error(errors: 'There was a problem logging out', status: :unprocessable_entity) and return unless result.success?

        render_success(Payload: 'You have been logged out', status: :ok)
      end

      def me
        render_success(payload: UserBlueprint.render(@current_user, view: :normal), status: :ok)
      end
    end
  end
end
