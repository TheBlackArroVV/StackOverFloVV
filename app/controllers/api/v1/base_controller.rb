class Api::V1::BaseController < ApplicationController
  before_action :doorkeeper_authorize!

  authorize_resource

  respond_to :json

  protected

  def current_resource_owner
    @user ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
