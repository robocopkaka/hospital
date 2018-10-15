require 'rails_helper'

RSpec.describe Appointment, type: :model do
  describe 'values are present' do
    let!(:doctor) { create :doctor_with_specialization, admin: true }
    it { should validate_presence_of(:appointment_date) }
  end

  describe 'associations' do
    it { should belong_to(:patient) }
    it { should belong_to(:doctor) }
  end
end
