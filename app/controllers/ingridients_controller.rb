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

  def edit
    @ingridient = Ingridient.find(params[:id])
    @recipe = @ingridient.recipe
  end  

  def update
    @ingridient = Ingridient.find(params[:id])
    @recipe = @ingridient.recipe

    if @ingridient.update(ingridient_params)
      redirect_to @recipe
    else
      render :edit
    end
  end

  def destroy
    @ingridient = Ingridient.find(params[:id])
    @recipe = @ingridient.recipe

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
end
