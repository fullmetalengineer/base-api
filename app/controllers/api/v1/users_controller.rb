# frozen_string_literal: true

module Api
  module V1
    # Handles endpoints related to users
    class UsersController < Api::V1::ApplicationController
      skip_before_action :authenticate, only: [:login, :create]

      def login
        result = BaseApi::Auth.login(params[:email], params[:password], @ip)
        render_error(errors: "User not authenticated", status: 401) and return unless result.success?

        payload = {
          user: UserBlueprint.render_as_hash(result.payload[:user], view: :login),
          token: TokenBlueprint.render_as_hash(result.payload[:token])
        }
        render_success(payload: payload)
      end

      def logout
        result = BaseApi::Auth.logout(@current_user, @token)
        render_error(errors: "There was a problem logging out", status: :unprocessable_entity) and return unless result.success?

        render_success(payload: "You have been logged out")
      end

      def me
        render_success(payload: UserBlueprint.render_as_hash(@current_user))
      end

      def validate_invitation
        user = User.invite_token_is(params[:invitation_token]).invite_not_expired.first

        render_success(payload: { validated: false }) and return if user.nil?

        render_success(payload: { validated: true })
      end
    end
  end
end
