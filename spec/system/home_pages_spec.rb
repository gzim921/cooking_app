require 'rails_helper'

RSpec.describe 'HomePages' do
  let(:user) { create(:user) }

  before do
    driven_by(:rack_test)

    visit root_path
  end

  describe 'Visiting root path while not logged in' do
    it 'has Recipes link' do
      expect(page).to have_link('Recipes')
    end

    it 'has Log In link' do
      expect(page).to have_link('Log In')
    end

    it 'has Sign Up link' do
      expect(page).to have_link('Sign Up')
    end

    context 'when trying to edit or create recipes' do
      it 'should give a flash error for creating' do
        visit '/recipes/new'
        expect(page).to have_content('You have to login!')
      end

      it 'should give a flash error for editing' do
        rec = create(:recipe)
        visit "/recipes/#{rec.id}/edit"
        expect(page).to have_content('You have to login!')
      end
    end
  end

  describe 'Logging in and signing up' do
    context 'when logging in' do
      before do
        click_on 'Log In'
      end

      it 'has content Log in into Cooking Diary' do
        expect(page).to have_content('Log in into Cooking Diary')
      end

      context 'after submiting' do
        before do
          log_in(user)
        end

        it 'should redirect to user profile after submit' do
          expect(page).to have_content(user.email)
          expect(page).to have_link('Edit profile')
        end

        it 'should have the link  New Recipe' do
          expect(page).to have_link('New Recipe')
        end

        it 'should have the link Log Out' do
          expect(page).to have_link('Log Out')
        end

        it 'should have the link Profile' do
          expect(page).to have_link('Profile')
        end
      end
    end

    context 'when signing up' do
      let(:first_name) { 'Test' }

      before do
        click_on 'Sign Up'

        within 'form' do
          fill_in 'First name', with: first_name
          fill_in 'Last name', with: 'testing'
          fill_in 'Email', with: 'test@gmail.com'
          fill_in 'Password', with: 'Test123!'
          fill_in 'Password confirmation', with: 'Test123!'

          click_button 'Sign Up'
        end
      end

      it 'should redirect to user profile after submit' do
        expect(page).to have_content(first_name)
      end

      it 'should has link Edit Profile' do
        expect(page).to have_link('Edit profile')
      end

      it 'should display All tweets content ' do
        expect(page).to have_content('Recipes')
      end
    end

    context 'when there are articles present' do
      let(:user) { create(:user) }
      let!(:recipe) { create(:recipe, user: user) }

      before do
        log_in(user)
        visit root_path
      end

      it 'should has user name' do
        expect(page).to have_content(recipe.user.first_name)
      end

      it 'should has the title' do
        expect(page).to have_content(recipe.title)
      end
    end
  end
end
