require 'rails_helper'

RSpec.describe Recipe do
  describe 'validations' do
    context 'presence' do
      it { should validate_presence_of(:title) }
      it { should validate_presence_of(:description) }
    end

    context 'length' do
      it do
        should validate_length_of(:title)
          .is_at_least(Recipe::MIN_TITLE_LENGTH)
          .is_at_most(Recipe::MAX_TITLE_LENGTH)
      end
      it do
        should validate_length_of(:description)
          .is_at_most(Recipe::MAX_DESC_LENGTH)
      end
    end
  end

  describe 'associations' do
    context 'relations' do
      it { should have_many(:instructions).dependent(:destroy) }
      it { should have_many(:ingridients).dependent(:destroy) }
      it do
        should accept_nested_attributes_for(:instructions)
          .allow_destroy(true)
      end
      it do
        should accept_nested_attributes_for(:ingridients)
          .allow_destroy(true)
      end
    end

    context 'dependecies' do
      context 'when destroying recipe' do
        let(:recipe) { create(:recipe) }
        it 'should destroy all instructions' do
          create_list(:instruction, 1, recipe: recipe)
          expect { Recipe.last.destroy }.to change { Instruction.count }.by(-1)
        end
        it 'should destroy all ingridients' do
          create_list(:ingridient, 1, recipe: recipe)
          expect { Recipe.last.destroy }.to change { Ingridient.count }.by(-1)
        end
      end
    end
  end
end
