class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'GitHub') if is_navigational_format?
    end
  end

  # def twitter
  #   pp request.env['omniauth.auth']
  #   render json: request.env['omniauth.auth']
  # end
end