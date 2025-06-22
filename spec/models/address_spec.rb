require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'associations' do
    it { is_expected.to have_one(:user).dependent(:nullify) }
  end

  describe 'basic validations' do
    context 'when any address field is set' do
      subject { build(:address, street_name: 'Foo') }

      it 'validates presence of street_name' do
        expect(subject).to validate_presence_of(:street_name)
      end

      it 'is invalid without street_name' do
        subject.street_name = nil
        expect(subject).not_to be_valid
      end
    end

    context 'when all address fields are blank' do
      subject { build(:address,
                      street_name: nil,
                      street_number: nil,
                      city: nil,
                      postal_code: nil,
                      country_name: nil) }

      it 'is valid' do
        expect(subject).to be_valid
      end
    end
  end
end
