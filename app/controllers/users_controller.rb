class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    if @user.save
      log_in(@user)
      redirect_to @user
    else
      flash.now[:danger] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    if logged_in?
      @user = User.find(params[:id])
      unless user_equals?(@user)
        flash[:danger] = 'You dont have permission!'
        redirect_to root_path
      end
    else
      flash[:danger] = 'You have to login!'
      redirect_to login_path
    end
  end

  def update
    if logged_in?
      @user = User.find(params[:id])

      unless user_equals?(@user)
        flash[:danger] = 'You dont have permission!'
        redirect_to root_path and return
      end

      if @user.update(user_params)
        redirect_to @user
      else
        render :edit
      end
    else
      flash[:danger] = 'You have to login!'
      redirect_to login_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name,
                                 :email, :password, :password_confirmation)
  end
end
