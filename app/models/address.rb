class Address < ApplicationRecord
  validates :street_name, presence: true, length: { maximum:  100 }
  validates :street_number, presence: true, length: { maximum:  20 }
  validates :city, presence: true, length: { maximum:  100 }
  validates :postal_code, presence: true, length: { maximum:  20 }
  validates :country_name, presence: true, length: { maximum:  100 }
end
