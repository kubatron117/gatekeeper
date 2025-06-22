require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:tasks).dependent(:restrict_with_error) }
  end

  describe 'validations' do
    it 'is invalid without a name' do
      project = build(:project, name: nil)
      expect(project).not_to be_valid
      expect(project.errors[:name]).to include("can't be blank")
    end

    it 'is valid with a name' do
      project = build(:project, name: 'My Project')
      expect(project).to be_valid
    end
  end
end
