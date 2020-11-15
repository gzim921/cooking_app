require 'rails_helper'

RSpec.describe "RecipeRequests" do
  describe 'As not logged in user' do
    it 'should not allow to create recipe' do
      post_params = {
        params: {
          recipe: {
            title: 'Just testing',
            description: 'Also testing'
          }
        }
      }
      post recipes_path, post_params

      follow_redirect!
      expect(response.body).to include('You have to login!')
    end

    it 'should not allow to update recipe' do
      recipe = create(:recipe)

      post_params = {
        params: {
          recipe: {
            title: 'Just testing',
            description: 'Also testing'
          }
        }
      }

      patch recipe_path(recipe), post_params 

      follow_redirect!
      expect(response.body).to include('You have to login!')
    end

    it 'should not allow to destroy recipe' do
      recipe = create(:recipe)

      delete recipe_path(recipe)

      follow_redirect!
      expect(response.body).to include('You have to login!')
    end
  end

  describe 'As logged in user' do
    context 'when manipulating with recipes created by logged in user' do
      let(:user) { create(:user) }
      let(:recipe) { create(:recipe, user: user) }

      before do
        log_in_request(user)
      end

      it 'should allow to update' do
        patch_params = {
          params: {
            recipe: {
              title: 'Trying to hack it',
              description: 'Also hack it'
            }
          }
        }
        patch recipe_path(recipe), patch_params

        expect(response).to redirect_to(recipe_path(recipe))
        follow_redirect!
        expect(response.body).to include('Trying to hack it')
      end

      it 'should allow to delete' do
        delete recipe_path(recipe)

        expect(response).to redirect_to(root_path)
      end
    end

    context 'when trying to manipulate with other users recipes' do
      let(:user) { create(:user) }
      let(:recipe) { create(:recipe, user: user) }
      let(:other_user) { create(:user) }

      before do
        log_in_request(other_user)
      end

      it 'should not allow to edit them' do
        patch_params = {
          params: {
            recipe: {
              title: "Trying to hack it",
              description: 'Yes i am'
            }
          }
        }
        patch recipe_path(recipe), patch_params

        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include('You dont have permission!')
      end

      it 'should not allow to delete them' do 
        delete recipe_path(recipe)

        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include('You dont have permission!')
      end
    end
  end
end
