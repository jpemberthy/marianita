class ApplicationController < ActionController::API

  private

  def require_user
    unless current_user
      render text: "Forbidden", status: :forbidden
    end
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

end
