class TaskAttachment < ApplicationRecord
  belongs_to :task
  has_one_attached :file
  validates :file, presence: true
  validates :note, length: { maximum: 500 }, allow_blank: true
end
