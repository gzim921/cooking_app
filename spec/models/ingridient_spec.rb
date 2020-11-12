require 'rails_helper'

RSpec.describe Ingridient do
  describe 'validations' do
    context 'presence' do
      it { should validate_presence_of(:name) }
    end

    context 'length and format' do
      it { should allow_value('Sugar').for(:name) }

      it do
        should validate_length_of(:name)
          .is_at_least(Ingridient::MIN_NAME_LENGTH)
          .is_at_most(Ingridient::MAX_NAME_LENGTH)
      end
    end
  end

  describe 'associations' do
    context 'relations' do
      it { should belong_to(:recipe) }
      it { should have_db_index(:recipe_id) }
    end
  end
end
