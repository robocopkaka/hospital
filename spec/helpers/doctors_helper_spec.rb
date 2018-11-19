require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the DoctorsHelper. For example:
#
# describe DoctorsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe DoctorsHelper, type: :helper do
  let!(:appointment) { create :appointment }
  context 'when a doctor checks if they have appointments' do
    it 'returns true if he/she has' do
      doctor = appointment.doctor
      expect(doctor_has_appointments?(doctor)).to eq true
      expect(doctor_has_appointments?(doctor)).to_not eq false
    end
  end

  context 'when a doctor\'s appointments are reassigned' do
    let!(:appointment) { create :appointment }
    let!(:doctor) { create :doctor_with_specialization, admin: true }
    it 'should remove all appointments from the doctor' do
      doctor = appointment.doctor
      reassign_appointments(doctor)
      expect(doctor.appointments.count).to eq 0
    end
  end
end
