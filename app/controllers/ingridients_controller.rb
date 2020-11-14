class IngridientsController < ApplicationController
  before_action :find_ingridient, only: [:edit, :update, :destroy]

  def new
    if logged_in? 
      @recipe = Recipe.find(params[:recipe_id])
      @ingridient = @recipe.ingridients.build
    else
      flash[:danger] = 'You have to login!'
      redirect_to root_path
    end
  end

  def create
    if logged_in? 
      recipe = Recipe.find(params[:recipe_id])
      ingridient = recipe.ingridients.create(ingridient_params)

      if ingridient.save
        redirect_to recipe
      else
        render :new
      end
    else
      flash[:danger] = 'You have to login!'
      redirect_to root_path
    end
  end

  def edit
    unless logged_in?
      @ingridient = Ingridient.find(params[:id])
      @recipe = @ingridient.recipe
    end
  end

  def update
    if logged_in?
      if @ingridient.update(ingridient_params)
        redirect_to @recipe
      else
        render :edit
      end
    else
      flash[:danger] = 'You have to login!'
      redirect_to root_path
    end
  end

  def destroy
    if logged_in?
      if @ingridient.destroy
        redirect_to @recipe
      else
        render @recipe
      end
    else
      flash[:danger] = 'You have to login!'
      redirect_to root_path
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
end
