class SignupController < ApplicationController
    def create
    admin = Admin.new(admin_params)

    if admin.save
      payload = { admin_id: admin.id }
      session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
      tokens = session.login

      response.set_cookie(JWTSessions.access_cookie,
                          value: tokens[:access],
                          httponly: true,
                          secure: Rails.env.production? )

      render json: { csrf: tokens[:csrf] }
    else
      render json: { error: admin.errors.full_messages.join(' ') }, status: :unprocessable_entity
    end
  end


  private

    def admin_params
      params.permit(:email, :password, :password_confirmation)
    end
end
