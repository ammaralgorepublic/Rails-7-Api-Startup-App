class Api::V1::AuthenticationController < Api::V1::BaseController
  include Response
  skip_before_action :authenticate_request
  attr_reader :current_user

  def authenticate
    command = AuthenticateUser.call(params[:email], params[:password])
    if command.success?
      user = User.find(command.result[:user_id])
      user.update(auth_token: command.result[:auth_token])
      current_user = user
      json_success_response("User Login Successfully", 200, user)
    else
      json_error_response("Unauthorized User",400, command.errors[:user_authentication][0])
    end
  end
end