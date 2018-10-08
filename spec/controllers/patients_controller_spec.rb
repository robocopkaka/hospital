require 'rails_helper'

RSpec.describe PatientsController, type: :request do
  let!(:doctor) { create :doctor }
  let!(:patient) { create :patient }

  describe 'GET #edit' do
    it 'returns the edit template' do
      get edit_patient_path(patient.id)
      expect(response).to render_template :edit
    end
  end

  describe 'GET #index' do
    it 'returns the index template' do
      get patients_path
      expect(response).to render_template :index
    end
  end

  describe 'PUT #update' do
    let!(:params) do
      { patient: {
        name: 'Echo',
        email: 'echo@echo.com'
      } }
    end
    it 'redirects to the home page after creating a new patient' do
      put patient_path(patient.id), params: params
      expect(response).to redirect_to patient_url(patient)
      follow_redirect!
    end
  end

  describe 'get #show' do
    it 'renders the doctor\'s show page' do
      get patient_path(patient.id)
      expect(response).to render_template :show
    end
  end

  describe 'get #appointments' do
    let!(:appointment) do
      create :appointment, doctor_id: doctor.id, patient_id: patient.id
    end
    it 'shows a patient\'s appointments' do
      get appointments_patient_path(patient.id)
      expect(response).to render_template :appointments
      expect(response.body).to include doctor.name
      expect(response.body).to include doctor.email
    end
  end
end
