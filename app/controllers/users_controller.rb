class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_user, only: %i[show update destroy]

  # GET /users
  def index
    if current_user

      @users = User.where.not(role1: 1) if user_student
      @users = User.where(role1: 1) if user_teacher
      @users = User.all if user_admin
      @users1 = User.where(role1: 0) if user_teacher

      if user_teacher
        render json: { student: @users1, teacher: @users }
      else
        render json: { users: @users }
      end

    else
      render json: { message: 'Login first as admin and then access this page.' }, status: :unprocessable_entity
    end
    # @users = User.all if user_admin
    # @users = User.where(role: 3) if user_teacher
    # @users = User.where.not(role: 3) if user_student
    # render json: { users: gen_users }
  end

  # GET /users/1
  def show
    render json: @user
    # return render json: { user: user_info } if able_to_show
  end

  # POST /users
  def create
    if current_user.role1 == 2
      @user = User.new(user_params)

      @user.save
      render json: @user, status: :created, location: @user
    else
      render plain: @user.errors.full_messages
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # def create
  #   # if the role of the current login user is admin then only create a user
  #   if current_user.role1 == 2
  #     if check_user_params
  #       build_resource(sign_up_params)

  #       resource.save
  #       yield resource if block_given?
  #       if resource.persisted?
  #         if resource.active_for_authentication?
  #           set_flash_message! :notice, :signed_up
  #           sign_up(resource_name, resource)
  #           respond_with resource, location: after_sign_up_path_for(resource)
  #         else
  #           set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
  #           expire_data_after_sign_in!
  #           respond_with resource, location: after_inactive_sign_up_path_for(resource)
  #         end
  #       else
  #         clean_up_passwords resource
  #         set_minimum_password_length
  #         respond_with resource
  #       end
  #     else
  #       wrong_params
  #     end
  #   else
  #     # else send registration failed or not authorize message
  #     register_failed
  #   end
  # end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email, :role1)
    # params.require(:user).permit(:email, :role1)
  end
end
