class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
               .try(:authenticate, params[:session][:password])

    if user
      log_in(user)
      redirect_to user_path(user)
    else
      flash.now[:danger] = "Email and password doesn't match"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
