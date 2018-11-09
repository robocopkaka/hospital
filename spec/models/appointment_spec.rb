require 'rails_helper'

RSpec.describe Appointment, type: :model do
  describe 'values are present' do
    let!(:doctor) { create :doctor_with_specialization, admin: true }
    it { should validate_presence_of(:appointment_date) }
  end

  describe 'only accept date at least one day from current date' do
    let!(:appointment) { create :appointment }
    context 'when the appointment has a date in the future' do
      it 'should be valid' do
        expect(appointment).to be_valid
      end
    end
    context 'when the appointment has a date in the past' do
      it 'should be not valid' do
        appointment.appointment_date = 1.day.ago
        expect(appointment).to_not be_valid
      end
    end
    context 'when the appointment\'s date is the same as the current date' do
      it 'should be not valid' do
        appointment.appointment_date = Date.today
        expect(appointment).to_not be_valid
      end
    end
  end

  describe 'associations' do
    it { should belong_to(:patient) }
    it { should belong_to(:doctor) }
  end
end
