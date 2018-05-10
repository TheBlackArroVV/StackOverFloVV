module ControllerMacros
  def login_user
    before do
      @user = create(:user)
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @user.confirm
      sign_in @user
    end
  end
end
