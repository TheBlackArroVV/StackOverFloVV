class Api::V1::ProfilesController < Api::V1::BaseController
  skip_authorization_check

  def me
    respond_with current_resource_owner
  end

  def users
    respond_with User.other_users(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
