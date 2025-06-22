class Task < ApplicationRecord
  enum :status, { created: 1, in_progress: 2, waiting_for_client: 3, completed: 4 }

  belongs_to :user
  belongs_to :project
  has_many :task_attachments, dependent: :destroy, inverse_of: :task
  accepts_nested_attributes_for :task_attachments,
                                allow_destroy: true,
                                reject_if: ->(attrs){ attrs['file'].blank? && attrs['note'].blank? }

  validates :subject, presence: true, length: { maximum: 255 }
  validates :status, presence: true, inclusion: { in: statuses.keys }
  validates :user_id, presence: true
  validates :project_id, presence: true

  before_validation :assign_default_status, on: :create
  after_create :enqueue_notify_users

  has_rich_text :description

  private

  def assign_default_status
    if self.status.nil?
      self.status = :created
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "project_id", "status", "subject", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["project"]
  end

  def enqueue_notify_users
    NotifyUsersJob.perform_later(self.id)
  end
end
