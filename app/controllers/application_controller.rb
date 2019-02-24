class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  # def current_resource_owner
  #   User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  # end

  # def current_user
  #   current_resource_owner
  # end
end
