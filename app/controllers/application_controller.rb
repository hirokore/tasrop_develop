class ApplicationController < ActionController::Base
  def move_to_signed_in
    unless user_signed_in?
      redirect_to  '/users/sign_in',notice: "ログインしてください。"
    end
  end
end
