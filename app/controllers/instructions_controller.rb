class InstructionsController < ApplicationController
  before_action :require_login
  before_action :find_instruction, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @instruction = @recipe.instructions.build
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @instruction = @recipe.instructions.create(instruction_params)
    
    if @instruction.save
      redirect_to @recipe
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @instruction.update(instruction_params)
      redirect_to @recipe
    else
      render :edit
    end
  end

  def destroy
    if @instruction.destroy
      redirect_to @recipe
    else
      render @recipe
    end
  end

  private

  def instruction_params
    params.require(:instruction).permit(:order, :instruction_info)
  end

  def find_instruction
    @instruction = Instruction.find(params[:id])
    @recipe = @instruction.recipe
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
