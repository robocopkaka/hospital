require 'rails_helper'

RSpec.describe "home/index.html.erb", type: :view do
  describe 'home page' do
    context 'when user is not signed in' do
      it 'shows links for non-logged in users' do
        render template: 'home/index.html.erb'
        expect(rendered).to match 'Signup'
        expect(rendered).to match 'Login'
        expect(rendered).to_not match 'Make an appointment'
      end
    end
    context 'when a doctor is logged in' do
      login_doctor
      it 'shows the buttons for a doctor' do
        render template: 'home/index.html.erb'

        expect(rendered).to match 'View appointment history'
        expect(rendered).to_not match 'Make an appointment'
      end
    end
    context 'when a patient is logged in' do
      login_patient
      it 'shows the buttons for a patient' do
        render template: 'home/index.html.erb'

        expect(rendered).to match 'View appointment history'
        expect(rendered).to match 'Make an appointment'
        expect(rendered).to_not match 'Signup'
        expect(rendered).to_not match 'Login'
      end
    end
  end
end
