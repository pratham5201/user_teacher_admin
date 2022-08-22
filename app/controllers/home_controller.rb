class HomeController < ApplicationController
 def home
    if current_user
      show_info({"message" => "#{current_user.email}! Welcome to the Student Notices API", "user" => current_user_data})
    else
     show_info({"message" => "Welcome to the Student Notices API", "prompt" => "Please Login to perform api actions."})
    end

  end

  private

  # Creating user information in json
  
  def current_user_data
   hash={0 =>"Student",1=>"Teacher",2 =>"Admin" }
    data = {
      id: current_user.id,
    #   name: current_user.name,
      email: current_user.email,
      role: hash[current_user.role1]
    #   role: current_user.role.name
    }
    

    if user_admin or user_teacher
        hash={0=>"Student",1=>"Teacher",2=>"Admin" }
        data = {
        id: current_user.id,
        # name: current_user.name,
        email: current_user.email,
        role: hash[current_user.role1],
        # role: current_user.role.name,
        # notice_count: current_user.notices.length,
        notices: gen_notices(current_user)
      }

    end

    return data
  end
end