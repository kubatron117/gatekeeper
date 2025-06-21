class Address < ApplicationRecord
  has_one :user, inverse_of: :address, dependent: :nullify

  with_options if: :partial_address? do
    validates :street_name,   presence: true, length: { maximum: 100 }
    validates :street_number, presence: true, length: { maximum: 20 }
    validates :city,          presence: true, length: { maximum: 100 }
    validates :postal_code,   presence: true, length: { maximum: 20 }
    validates :country_name,  presence: true, length: { maximum: 100 }
  end

  private

  def partial_address?
    [street_name, street_number, city, postal_code, country_name]
      .any?(&:present?)
  end
end
