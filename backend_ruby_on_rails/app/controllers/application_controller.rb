class ApplicationController < ActionController::API
    include JWTSessions::RailsAuthorization
  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized

  private

    def current_admin
      @current_admin ||= Admin.find(payload['admin_id'])
    end

    def not_authorized
      render json: { error: 'Not authorized' }, status: :unauthorized
    end

end

