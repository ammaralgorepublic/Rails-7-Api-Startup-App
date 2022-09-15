class Api::V1::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_request
  attr_reader :current_user

  private

  def authenticate_request
    command = AuthorizeApiRequest.call(request.headers)
    if command.success?
      @current_user = command.result
    else
      render json: { error: 'Not Authorized' }, status: 401
    end
  end
end