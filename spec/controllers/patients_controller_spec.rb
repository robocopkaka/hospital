require 'rails_helper'

RSpec.describe PatientsController, type: :request do
  let!(:doctor) { create :doctor_with_specialization, :admin }
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
    it 'redirects to the home page after updating a new patient' do
      sign_in patient
      put patient_path(patient.id), params: params
      expect(response).to redirect_to patient_url(patient)
      follow_redirect!
    end
    it 'renders the edit page if the update is unsuccessful' do
      sign_in patient
      params[:patient][:email] = 'kachi'
      put patient_path(patient.id), params: params
      expect(response).to render_template :edit
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
      create :appointment
    end
    it 'shows a patient\'s appointments' do
      get appointments_patient_path(patient.id)
      expect(response).to render_template :appointments
      expect(response.body).to include doctor.name
      expect(response.body).to include doctor.email
    end
  end

  describe 'DELETE #destroy' do
    it 'should delete a patient from the database' do
      expect do
        delete patient_path(patient.id)
      end.to change(Patient, :count).by(-1)
    end
  end
end
