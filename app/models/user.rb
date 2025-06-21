class User < ApplicationRecord
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :address, optional: true, dependent: :destroy

  accepts_nested_attributes_for :address,
                                allow_destroy: true,
                                reject_if: :all_blank
  has_one_attached :avatar

  enum :role, { admin: 1, user: 2 }

  validates :first_name, presence: true, length: { maximum: 100 }
  validates :last_name, presence: true, length: { maximum: 100 }
  #todo: validate email

  before_create :set_default_role

  def to_s
    "#{first_name} #{last_name} (#{email})"
  end

  private

  def set_default_role
    self.role ||= :user
  end
end
