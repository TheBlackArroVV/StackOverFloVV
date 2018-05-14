require "application_responder"

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  self.responder = ApplicationResponder
  respond_to :html

  before_action :gon_user, unless: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  def gon_user
    gon.user_id = current_user.id if user_signed_in?
  end

  check_authorization unless: :devise_controller?
end
