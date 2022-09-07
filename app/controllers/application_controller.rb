class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  # include ::ActionController::Cookies

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[role1 email password])
  end

  rescue_from CanCan::AccessDenied do
    render json: { message: 'You are not authorized for this!' }
  end

  #   rescue_from NoMethodError: undefined method do
  # render json: { message: 'You are not authorized for this!' }
  #   end

  def show_info(response)
    render json: response, status: 200
  end

  def user_admin
    current_user.role1 == 2
  end

  def user_student
    current_user.role1 == 0
  end

  def user_teacher
    current_user.role1 == 1
  end

  def gen_notices(user)
    user.notices do |notice|
      {
        id: notice.id,
        title: notice.title,
        description: notice.discription,
        # url: notice_url(notice),
        created_at: notice.created_at,
        updated_at: notice.updated_at
      }
    end
  end
end
