class Project < ApplicationRecord
  has_many :tasks, dependent: :restrict_with_error

  validates :name, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 2000 }

  after_create_commit :broadcast_new_project


  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "description", "created_at", "updated_at"]
  end

  private
  def broadcast_new_project
    User.find_each do |user|
      NotificationsChannel.broadcast_to(
        user,
        message: "New project ― #{self.name}."
      )
    end
  end
end
