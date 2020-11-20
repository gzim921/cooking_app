require 'rails_helper'

RSpec.describe Instruction do
  describe 'validations' do
    context 'presence' do
      it { should validate_presence_of(:order) }
      it { should validate_presence_of(:instruction_info) }
    end

    context 'length and type' do
      it do
        should validate_numericality_of(:order)
          .only_integer.is_greater_than(0)
      end

      it do
        should validate_length_of(:instruction_info)
          .is_at_least(Instruction::MIN_INS_LENGTH)
          .is_at_most(Instruction::MAX_INS_LENGTH)
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
