class AddRecipeToInstructions < ActiveRecord::Migration[6.0]
  def change
    add_reference :instructions, :recipe, index: true
  end
end
