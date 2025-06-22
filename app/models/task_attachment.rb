class TaskAttachment < ApplicationRecord
  belongs_to :task

  has_one_attached :file

  validates :file,
            attached: true,
            content_type: {
              in: ['image/png', 'image/jpeg', 'application/pdf', 'image/tiff'],
              message: 'must be PNG, JPEG, TIFF or PDF.' },
            size: {
             between: 1.kilobyte..50.megabytes,
             message: 'size must be between 1 KB and 50 MB' }

  validates :note, length: { maximum: 500 }, allow_blank: true
end
