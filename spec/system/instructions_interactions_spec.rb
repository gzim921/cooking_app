require 'rails_helper'

RSpec.describe "InstructionsInteractions" do
  let(:recipe) { create(:recipe) }
  let!(:instruction) { create(:instruction, recipe: recipe) }

  before do
    driven_by(:rack_test)

    visit recipe_path(recipe)
  end

  describe 'Creating new instruction' do
    before do
      click_on 'Add Instruction'
    end

    context 'when clicking button Add Instruction' do
      it 'should display instruction form and have button Create' do
        expect(page).to have_button('Create Instruction')
      end
    end

    context 'when submiting the form' do
      it 'should create instruction and redirect to recipe' do
        order = 1
        instruction_info = 'testing instruction'

        within('form') do
          fill_in 'instruction_order', with: order
          fill_in 'instruction_instruction_info', with: instruction_info

          click_on 'Create Instruction'
        end

        expect(page).to have_content(order)
        expect(page).to have_content(instruction_info)
        expect(page).to have_content(recipe.title)
      end
    end
  end

  describe 'Editing instruction' do
    it 'should update instruction and redirect to recipe' do
      instruction_info_updated = 'Not useful'

      visit edit_recipe_instruction_path(recipe, instruction)

      within('form') do
        fill_in 'instruction_instruction_info', with: instruction_info_updated

        click_on 'Update Instruction'
      end

      expect(page).to have_content(instruction_info_updated)
      expect(page).to have_content(recipe.title)
    end
  end

  describe 'Deleting instruction' do
    it 'should delete instruction and redirect to recipe' do
      click_link('Delete', href: recipe_instruction_path(recipe, instruction))

      expect(page).not_to have_content(instruction.instruction_info)
      expect(page).to have_content(recipe.title)
    end
  end
end
