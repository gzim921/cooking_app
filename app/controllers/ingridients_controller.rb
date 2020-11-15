class IngridientsController < ApplicationController
  before_action :require_login
  before_action :find_ingridient, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @ingridient = @recipe.ingridients.build
  end

  def create
    recipe = Recipe.find(params[:recipe_id])
    ingridient = recipe.ingridients.create(ingridient_params)

    if ingridient.save
      redirect_to recipe
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @ingridient.update(ingridient_params)
      redirect_to @recipe
    else
      render :edit
    end
  end

  def destroy
    if @ingridient.destroy
      redirect_to @recipe
    else
      render @recipe
    end
  end

  private

  def ingridient_params
    params.require(:ingridient).permit(:name)
  end

  def find_ingridient
    @ingridient = Ingridient.find(params[:id])
    @recipe = @ingridient.recipe
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
      redirect_to root_path
    end
  end
end
