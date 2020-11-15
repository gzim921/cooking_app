module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def logged_in?
    current_user.present?
  end

  def log_out
    session.clear
    @current_user = nil
  end

  def user_equals?(other_user)
    current_user == other_user
  end

  def user_full_name(user)
    "#{user.first_name} #{user.last_name}"
  end
end
