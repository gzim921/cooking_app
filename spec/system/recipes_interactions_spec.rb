require 'rails_helper'

RSpec.describe 'RecipesInteractions' do
  let(:recipe) { create(:recipe) }

  before do
    driven_by(:rack_test)

    visit root_path
  end

  describe 'Creating a recipe' do
    before do
      click_on 'New Recipe'
    end

    context 'when clicking button New Recipe' do
      it 'should have button cancel' do
        expect(page).to have_content('Cancel')
      end

      it 'should have button Create Recipe' do
        expect(page).to have_button('Create Recipe')
      end

      it 'should have a button for deleting nested fields' do
        expect(page).to have_selector('i.fa-times')
      end

      it 'should have a button for adding nested fields' do
        expect(page).to have_content('Add')
      end
    end

    context 'when submiting the form without instructions and ingridients' do
      it 'creates and shows created recipe without instructions and ingridients' do
        title = 'Recipe'
        description = 'This is description testing'

        within('form') do
          fill_in 'Title', with: title
          fill_in 'Description', with: description

          click_on 'Create Recipe'
        end

        expect(page).to have_content(title)
        expect(page).to have_content(description)
      end
    end

    context 'when submiting the form with instructions and ingridients' do
      it 'creates and shows created recipe with instructions and ingridients' do
        title = 'Recipe'
        description = 'This is description testing'
        instruction_info = 'Instruction info test'
        ing_name = 'Sugar'

        within('form') do
          fill_in 'Title', with: title
          fill_in 'Description', with: description
          fill_in 'recipe_instructions_attributes_0_order', with: 1
          fill_in 'recipe_instructions_attributes_0_instruction_info', with: instruction_info
          fill_in 'recipe_ingridients_attributes_0_name', with: ing_name

          click_on 'Create Recipe'
        end
        expect(page).to have_content(title)
        expect(page).to have_content(description)
        expect(page).to have_content(ing_name)
      end
    end
  end

  describe 'Editing a recipe' do
    before do
      visit recipe_path(recipe)

      click_on 'Edit'
    end

    context 'when clicking button Update' do
      it 'should update recipe and show the recipe' do
        title = 'Test for update'
        description = 'Test desc'

        within('form') do
          fill_in 'Title', with: title
          fill_in 'Description', with: description

          click_on 'Update Recipe'
        end

        expect(page).to have_content(title)
        expect(page).to have_content(description)
      end
    end

    context 'when clicking button cancel' do
      it 'should go back to root path' do
        click_on 'Cancel'

        expect(page).to have_content(recipe.title)
        expect(page).to have_content('Show')
        expect(page).to have_content('Edit')
      end
    end
  end

  describe 'Deleting a recipe' do
    it 'should delete recipe and redirect to root path' do
      visit recipe_path(recipe)

      click_on 'Delete'

      expect(page).not_to have_content(recipe.title)
      expect(page).not_to have_content('Show')
    end
  end
end
