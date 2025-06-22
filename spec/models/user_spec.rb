require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:address).dependent(:destroy).optional }
    it { is_expected.to have_many(:tasks).dependent(:restrict_with_error) }
    it { is_expected.to have_one_attached(:avatar) }
  end

  describe 'validations' do
    it 'is invalid without a first_name' do
      user = build(:user, first_name: nil)
      expect(user).not_to be_valid
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    it 'is valid with a first_name' do
      user = build(:user, first_name: 'John')
      expect(user).to be_valid
    end

    it 'is invalid without a last_name' do
      user = build(:user, last_name: nil)
      expect(user).not_to be_valid
      expect(user.errors[:last_name]).to include("can't be blank")
    end

    it 'is valid with a last_name' do
      user = build(:user, last_name: 'Doe')
      expect(user).to be_valid
    end

    it 'is invalid without a email' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'is valid with a email' do
      user = build(:user, email: 'john@doe.com')
      expect(user).to be_valid
    end
  end
end
