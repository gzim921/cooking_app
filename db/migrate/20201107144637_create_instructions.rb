class CreateInstructions < ActiveRecord::Migration[6.0]
  def change
    create_table :instructions do |t|
      t.integer :order
      t.text :instruction_info

      t.timestamps
    end
  end
end
