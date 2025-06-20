class Task < ApplicationRecord
  belongs_to :user
  belongs_to :project

  enum status: { new: 1, in_progress: 2, waiting_for_client: 3, completed: 4 }

  validates :subject, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 2000 }
  validates :status, presence: true, inclusion: { in: statuses.keys }
  validates :user_id, presence: true
  validates :project_id, presence: true

  before_create :assign_default_status


  private

  def assign_default_status
    if self.status.nil?
      self.status = :new
    end
  end
end
