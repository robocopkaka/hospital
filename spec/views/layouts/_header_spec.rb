# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'layouts/_header.html.erb', type: :view do
  describe 'doctors logged in' do
    login_doctor

    context 'when a doctor is logged in' do
      it 'only shows the link for doctors' do
        render template: 'layouts/_header.html.erb'

        expect(rendered).to match 'doctors'
        expect(rendered).to_not match 'Specializations'
      end
    end
  end

  describe 'admins logged in' do
    login_admin
    context 'when the doctor is an admin' do
      it 'renders admin-only links' do
        render template: 'layouts/_header.html.erb'
        expect(rendered).to match 'Specializations'
        expect(rendered).to match 'Patients'
      end
    end
  end

  describe 'patients logged in' do
    login_patient
    context 'when a patient is logged in' do
      it 'only shows the links patients can see' do
        render template: 'layouts/_header.html.erb'
        expect(rendered).to match 'Make an appointment'
        expect(rendered).to_not match 'Patients'
      end
    end
  end
end
