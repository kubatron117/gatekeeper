class User < ApplicationRecord
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :address, optional: true, dependent: :destroy

  accepts_nested_attributes_for :address,
                                allow_destroy: true,
                                reject_if: :all_blank
  has_one_attached :avatar

  has_many :tasks, dependent: :restrict_with_error, inverse_of: :user

  enum :role, { admin: 1, user: 2 }

  validates :first_name, presence: true, length: { maximum: 100 }
  validates :last_name, presence: true, length: { maximum: 100 }
  validates :role, presence: true, inclusion: { in: roles.keys }
  validates :avatar,
            content_type: {
              in: ['image/png', 'image/jpeg', 'image/tiff'],
              message: 'must be PNG, JPEG or TIFF.' },
            size: {
              between: 1.kilobyte..50.megabytes,
              message: 'size must be between 1 KB and 50 MB' }

  before_validation :set_default_role, on: :create

  def to_s
    "#{first_name} #{last_name} (#{email})"
  end

  private

  def set_default_role
    self.role ||= :user
  end
end
