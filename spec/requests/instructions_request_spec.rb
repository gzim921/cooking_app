require 'rails_helper'

RSpec.describe 'Instructions' do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, user: user) }
  let(:instruction) { create(:instruction, recipe: recipe) }

  describe 'As not logged in user' do
    it 'should not allow to create instruction' do
      post_params = {
        params: {
          instruction: {
            order: 3,
            instruction_info: 'Just testing'
          }
        }
      }

      post recipe_instructions_path(recipe), post_params

      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include('You have to login!')
    end

    it 'should not allow to edit instruction' do
      patch_params = {
        params: {
          instruction: {
            order: 3,
            instruction_info: 'Just'
          }
        }
      }

      patch recipe_instruction_path(recipe, instruction), patch_params

      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include('You have to login!')
    end

    it 'should not allow to delete it' do
      delete recipe_instruction_path(recipe, instruction)

      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include('You have to login!')
    end
  end

  describe 'As logged in user' do
    let(:user_2) { create(:user) }
    let(:recipe_2) { create(:recipe, user: user_2) }
    let(:instruction_2) { create(:instruction, recipe: recipe_2) }

    before do
      log_in_request(user_2)
    end

    context 'when manipulating with others recipe' do
      it 'should not allow to edit instruction' do
        patch_params = {
          params: {
            instruction: {
              order: 3,
              instruction_info: 'Just'
            }
          }
        }

        patch recipe_instruction_path(recipe, instruction), patch_params

        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include('You dont have permission!')
      end

      it 'should not allow to delete it' do
        delete recipe_instruction_path(recipe, instruction)

        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include('You dont have permission!')
      end
    end

    context 'when manipulating with his recipes' do
      it 'should create instruction' do
        ins_info = 'Just testing'

        post_params = {
          params: {
            instruction: {
              order: 3,
              instruction_info: ins_info
            }
          }
        }

        post recipe_instructions_path(recipe_2), post_params

        expect(response).to redirect_to(recipe_2)
        follow_redirect!
        expect(response.body).to include('Just testing')
      end

      it 'should allow to edit instruction' do
        ins_info = 'Just'

        patch_params = {
          params: {
            instruction: {
              order: 3,
              instruction_info: ins_info
            }
          }
        }

        patch recipe_instruction_path(recipe_2, instruction_2), patch_params

        expect(response).to redirect_to(recipe_2)
        follow_redirect!
        expect(response.body).to include(ins_info)
      end

      it 'should allow to delete instruction' do
        delete recipe_instruction_path(recipe_2, instruction_2)

        expect(response).to redirect_to(recipe_2)
      end
    end
  end
end
