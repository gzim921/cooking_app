class UsersController < ApplicationController
  before_action :require_login, only: [:eidt, :update]
  before_action :find_user, except: [:new, :create]
  before_action :correct_user, only: [:edit, :update]

  def show
  end

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

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name,
                                 :email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def correct_user
    unless user_equals?(@user)
      flash[:danger] = 'You dont have permission!'
      redirect_to root_path and return
    end
  end

  def require_login
    unless logged_in?
      flash[:danger] = 'You have to login!'
      redirect_to login_path
    end
  end
end
