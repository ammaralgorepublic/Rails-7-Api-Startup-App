module Response

  def json_success_response(message, status, data = {})
    render json: { success: true, status: status,  message: message, data: data }
  end

  def json_error_response(message, status, errors = {})
    render json: { success: false, message: message, status: status, errors: errors }
  end
end