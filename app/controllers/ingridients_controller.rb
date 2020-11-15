class IngridientsController < ApplicationController
  before_action :find_ingridient, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @recipe = Recipe.find(params[:recipe_id])
    if user_equals?(@recipe.user)
      @ingridient = @recipe.ingridients.build
    else
      flash[:danger] = 'You dont have permission!'
      redirect_to root_path and return
    end
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])

    if user_equals?(@recipe.user)
      @ingridient = @recipe.ingridients.create(ingridient_params)

      if @ingridient.save
        redirect_to @recipe
      else
        render :new
      end
    else
      flash[:danger] = 'You dont have permission!'
      redirect_to root_path and return
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
end
