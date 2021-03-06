class ApplicationController < ActionController::Base
  def move_to_signed_in
    unless user_signed_in?
      redirect_to  '/users/sign_in',notice: "ログインしてください。"
    end
  end
  
  def after_sign_in_path_for(resource)
    current_user
  end

  def role_change!(user,param)
    if param == "user"
      user.user!
      user.save!
    elsif param == "admin"
      user.admin!
      user.save!
    end
  end
  
end
