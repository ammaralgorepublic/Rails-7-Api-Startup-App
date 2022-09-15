class Api::V1::UsersController < Api::V1::BaseController
  include Response
  skip_before_action :authenticate_request
  before_action :get_user, only: %i[update show destroy logout]

  # Listing of all the Users registered in this APP.
  def index
    @user = User.all
      json_success_response("Listing of all Users", 200, users: @user)
  end

  # User Detail of the specific User.
  def show
    if @user.present?
      json_success_response("User Details", 200, user: @user)
    else
      json_error_response("No User Found", 400, nil)
    end
  end

  # Creating New User
  def create
    @user = User.new(user_params)
    if @user.save
      json_success_response("User Created", 200, user: @user)
    else
      json_error_response("Unable To Create User", 400, @user.errors.full_messages)
    end
  end

  # Updating The Existing User
  def update
    if @user.update(user_params)
      json_success_response("User Updated", 200, user: @user)
    else
      json_error_response("Unable To Update User", 400, @user.errors.full_messages)
    end
  end

  # Deleting the Specific User.
  def destroy
    if @user.present?
      @user.destroy
      json_success_response("User Deleted", 200, user: @user)
    else
      json_error_response("Unable To Delete User", 400, nil)
    end
  end

  # Logout the Current user by updating their auth token.
  def logout
    if @user.present?
      @user.update(auth_token: nil)
      json_success_response("User Successfully Logout", 200, user: @user)
    else
      json_error_response("No User found", 400, nil)
    end
  end

  private

  # User Params
  def user_params
    params.permit(:firstname, :lastname, :email, :password)
  end

  # Getting User By ID
  def get_user
    @user = User.find_by(id: params[:id])
  end
end