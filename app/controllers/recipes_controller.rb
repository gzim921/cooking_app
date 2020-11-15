class RecipesController < ApplicationController
  before_action :require_login, except: [:show]
  before_action :find_recipe, except: [:index, :new, :create]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @recipes = Recipe.all
  end

  def show
  end

  def new
    if logged_in?
      @recipe = Recipe.new
      @recipe.instructions.build
      @recipe.ingridients.build
    else
      flash[:danger] = 'You have to login'
      redirect_to login_path
    end
  end

  def create
    if logged_in?
      @recipe = Recipe.create(recipe_params)
      @recipe.user = current_user

      if @recipe.save
        redirect_to root_path
      else
        render :new
      end
    else
      flash[:danger] = 'You have to login!'
      redirect_to login_path
    end
  end

  def edit
    unless logged_in?
      flash[:danger] = 'You have to login!'
      redirect_to login_path
    end
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render :edit
    end
  end

  def destroy
    if @recipe.destroy
      redirect_to root_path
    else
      render @recipe
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :description, instructions_attributes: %i[id order instruction_info _destroy], ingridients_attributes: %i[id name _destroy])
  end

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def correct_user
    unless user_equals?(@recipe.user)
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
