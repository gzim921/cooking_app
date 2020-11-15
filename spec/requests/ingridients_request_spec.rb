require 'rails_helper'

RSpec.describe 'Ingridients' do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, user: user) }
  let(:ingridient)  { create(:ingridient, recipe: recipe) }

  describe 'As not logged in user' do
    it 'should not allow to create ingridient' do
      post_params = {
        params: {
          ingridient: {
            name: 'Just testing'
          }
        }
      }

      post recipe_ingridients_path(recipe), post_params

      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include('You have to login!')
    end

    it 'should not allow to edit ingridient' do
      patch_params = {
        params: {
          ingridient: {
            name: 'Just'
          }
        }
      }

      patch recipe_ingridient_path(recipe, ingridient), patch_params

      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include('You have to login!')
    end

    it 'should not allow to delete it' do
      delete recipe_ingridient_path(recipe, ingridient)

      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include('You have to login!')
    end
  end

  describe 'As logged in user' do
    let(:user_2) { create(:user) }
    let(:recipe_2) { create(:recipe, user: user_2) }
    let(:ingridient_2) { create(:ingridient, recipe: recipe_2) }

    before do
      log_in_request(user_2)
    end

    context 'when manipulating with others recipe' do
      it 'should not allow to edit ingridient' do
        patch_params = {
          params: {
            ingridient: {
              name: 'Just'
            }
          }
        }

        patch recipe_ingridient_path(recipe, ingridient), patch_params

        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include('You dont have permission!')
      end

      it 'should not allow to delete it' do
        delete recipe_ingridient_path(recipe, ingridient)

        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include('You dont have permission!')
      end
    end

    context 'when manipulating with his recipes' do
      it 'should create ingridient' do
        ing_info = 'Just testing'

        post_params = {
          params: {
            ingridient: {
              name: ing_info
            }
          }
        }

        post recipe_ingridients_path(recipe_2), post_params

        expect(response).to redirect_to(recipe_2)
        follow_redirect!
        expect(response.body).to include('Just testing')
      end

      it 'should allow to edit ingridient' do
        ing_info = 'Just'

        patch_params = {
          params: {
            ingridient: {
              name: ing_info
            }
          }
        }

        patch recipe_ingridient_path(recipe_2, ingridient_2), patch_params

        expect(response).to redirect_to(recipe_2)
        follow_redirect!
        expect(response.body).to include(ing_info)
      end

      it 'should allow to delete ingridient' do
        delete recipe_ingridient_path(recipe_2, ingridient_2)

        expect(response).to redirect_to(recipe_2)
      end
    end
  end
end
