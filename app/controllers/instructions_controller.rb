class InstructionsController < ApplicationController
  before_action :find_instruction, only: [:edit, :update, :destroy]

  def new
    if logged_in?
      @recipe = Recipe.find(params[:recipe_id])
      @instruction = @recipe.instructions.build
    else
      flash[:danger] = 'You have to login!'
      redirect_to root_path
    end
  end

  def create
    if logged_in?
      @recipe = Recipe.find(params[:recipe_id])
      @instruction = @recipe.instructions.create(instruction_params)

      if @instruction.save
        redirect_to @recipe
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
      flash[:danger] = 'You have to login!'
      redirect_to root_path
    end
  end

  def update
    if logged_in?
      if @instruction.update(instruction_params)
        redirect_to @recipe
      else
        render :edit
      end
    else
      lash[:danger] = 'You have to login!'
      redirect_to root_path
    end
  end

  def destroy
    if logged_in?
      if @instruction.destroy
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

  def instruction_params
    params.require(:instruction).permit(:order, :instruction_info)
  end

  def find_instruction
    @instruction = Instruction.find(params[:id])
    @recipe = @instruction.recipe
  end
end
