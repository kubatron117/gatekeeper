require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:project) }
  end

  describe 'validations and defaults' do
    it 'is invalid without a subject' do
      task = build(:task, subject: nil)
      expect(task).not_to be_valid
      expect(task.errors[:subject]).to include("can't be blank")
    end

    it 'sets default status to created on build' do
      task = build(:task)
      expect(task.status).to eq('created')
    end

    it 'is valid with subject, user and project' do
      user    = create(:user)
      project = create(:project)
      task    = build(
        :task,
        subject: 'Do something',
        user:    user,
        project: project
      )

      expect(task).to be_valid
    end
  end
end
