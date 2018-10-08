require 'rails_helper'

RSpec.describe DoctorsController, type: :request do
  let!(:doctor) { create :doctor }
  let!(:patient) { create :patient }

  describe 'GET #edit' do
    it 'returns the edit template' do
      get edit_doctor_path(doctor.id)
      expect(response).to render_template :edit
    end
  end

  describe 'GET #index' do
    it 'returns the index template' do
      get doctors_path
      expect(response).to render_template :index
    end
  end

  describe 'PUT #update' do
    let!(:params) do
      { doctor: {
        name: 'Echo',
        email: 'echo@echo.com'
      } }
    end
    it 'redirects to the home page after creating a new doctor' do
      put doctor_path(doctor.id), params: params
      expect(response).to redirect_to :root
      follow_redirect!
    end
  end

  describe 'get #show' do
    it 'renders the doctor\'s show page' do
      get doctor_path(doctor.id)
      expect(response).to render_template :show
    end
  end

  describe 'get #appointments' do
    let!(:appointment) do
      create :appointment, doctor_id: doctor.id, patient_id: patient.id
    end
    it 'shows a doctor\'s appointments' do
      get appointments_doctor_path(doctor.id)
      expect(response).to render_template :appointments
      expect(response.body).to include patient.name
      expect(response.body).to include patient.email
    end
  end
end
