class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
  end

  def new
    @recipe = Recipe.new
    @recipe.instructions.build
    @recipe.ingridients.build
  end

  def create
    @recipe = Recipe.create(recipe_params)
    if @recipe.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :description, instructions_attributes: %i[id order instruction_info], ingridients_attributes: %i[id name])
  end
end
