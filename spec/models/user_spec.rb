require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    context 'presence' do
      it { should validate_presence_of(:first_name) }
      it { should validate_presence_of(:last_name) }
      it { should validate_presence_of(:email) }
    end

    context 'length' do
      it do
        should validate_length_of(:password)
          .is_at_least(User::MIN_PASS_LENGTH)
          .is_at_most(User::MAX_PASS_LENGTH)
          .with_message('must contain at least 6 characters')
      end
    end

    context 'password validations' do
      it { should have_secure_password }
      it { should validate_confirmation_of(:password) }
    end

    context 'format validations' do
      it { should allow_value('testing@gmail.com').for(:email) }
      it { should allow_value('Testing123!').for(:password) }
      it { should_not allow_value('testing@gmail').for(:email) }
      it { should_not allow_value('testing123').for(:password) }
    end

    context 'trying to create user with same email' do
      subject { create(:user) }
      it { is_expected.to validate_uniqueness_of(:email).with_message("already exists.") }
    end
  end

  describe 'authentications' do
    it { should have_many(:recipes).dependent(:destroy) }

    context 'dependecies' do
      context 'when destroying' do
        let(:user) { create(:user) }
        it 'should destroy all tweets' do
          create_list(:recipe, 1, user: user)
          expect { user.destroy }.to change { Recipe.count }.by(-1)
        end
      end
    end
  end
end
