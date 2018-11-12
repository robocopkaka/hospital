require 'rails_helper'

RSpec.describe 'appointments/new.html.erb', type: :view do
  let!(:specializations) { create_list :specialization_with_doctor, 3 }
  let!(:specialization) { create :specialization }
  let!(:appointment) { create :appointment }
  before do
    instance_variable_set(:@appointment, Appointment.first)
  end
  context 'when user wants to make an appointment' do
    it 'should only show specializations with doctors associated with them' do
      render template: 'appointments/new.html.erb'

      expect(rendered).to match specializations.first.name
      expect(rendered).to match specializations.second.name
      expect(rendered).to match specializations.third.name

      expect(rendered).to_not match specialization.name
    end
  end
end
