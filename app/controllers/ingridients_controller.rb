class IngridientsController < ApplicationController
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

  private

  def ingridient_params
    params.require(:ingridient).permit(:name)
  end
end
