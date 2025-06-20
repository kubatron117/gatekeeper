class Project < ApplicationRecord
  has_many :tasks, dependent: restrict_with_error

  validates :name, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 2000 }
end
