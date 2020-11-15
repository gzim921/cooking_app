require 'rails_helper'

RSpec.describe 'IngridientsInteractions' do
  let(:recipe) { create(:recipe) }
  let!(:ingridient) { create(:ingridient, recipe: recipe) }

  before do
    driven_by(:rack_test)

    log_in(create(:user))

    visit recipe_path(recipe)
  end

  describe 'Creating new ingridient' do
    before do
      click_on 'Add Ingridient'
    end

    context 'when clicking button Add Ingridient' do
      it 'should display ingridient form and have button Create' do
        expect(page).to have_button('Create Ingridient')
      end
    end

    context 'when submitting the form' do
      it 'should create ingridient and redierct to recipe' do
        ing_name = 'Milk'

        within('form') do
          fill_in 'ingridient_name',	with: ing_name

          click_on 'Create Ingridient'
        end

        expect(page).to have_content(ing_name)
        expect(page).to have_content(recipe.title)
      end
    end
  end

  describe 'Editing Ingridient' do
    it 'should update ingridient and redirect to recipe' do
      name_updated = 'Onion'

      visit edit_recipe_ingridient_path(recipe, ingridient)

      within('form') do
        fill_in 'ingridient_name',	with: name_updated

        click_on ' Update Ingridient'
      end

      expect(page).to have_content(name_updated)
      expect(page).to have_content(recipe.title)
    end
  end

  describe 'Deleting ingridient' do
    it 'should delete ingridient and redirect to recipe' do
      click_link('Delete', href: recipe_ingridient_path(recipe, ingridient))
      expect(page).not_to have_content(ingridient.name)
      expect(page).to have_content(recipe.title)
    end
  end
end
