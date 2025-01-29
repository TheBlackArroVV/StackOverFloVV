class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    if @user && @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'GitHub') if is_navigational_format?
    end
  end

  def twitter
    pp request.env['omniauth.auth'].provider
    pp request.env['omniauth.auth'].uid
    autorization = Authorization.find_by(provider: request.env['omniauth.auth'].provider, uid: request.env['omniauth.auth'].uid)
    if autorization
      @user = autorization.user
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Twitter') if is_navigational_format?
    else
      Authorization.create(provider: request.env['omniauth.auth'].provider, uid: request.env['omniauth.auth'].uid, user: User.last)
      render 'devise/registrations/email_only'
    end
  end
end