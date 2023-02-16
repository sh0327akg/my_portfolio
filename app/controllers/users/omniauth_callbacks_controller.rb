# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: %i[github]

  def github
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'github') if is_navigational_format?
    else
      session['devise.github_data'] = request.env['omniauth.auth'].except(:extra)
      redirect_to root_path
    end
  end

  def failure
    redirect_to root_path
  end
end