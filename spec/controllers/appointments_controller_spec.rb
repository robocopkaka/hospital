require 'rails_helper'

RSpec.describe AppointmentsController, type: :request do
  let!(:doctor) { create :doctor }
  let!(:patient) { create :patient }
  let!(:params) do
    { appointment: {
      appointment_date: Time.now,
      doctor_id: doctor.id,
      patient_id: patient.id
    } }
  end
  let!(:faulty_params) do
    { appointment: {
      doctor_id: 'a',
      patient_id: patient.id
    } }
  end
  describe 'GET #new' do
    it 'returns http success' do
      get new_appointment_path
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    it 'should redirect to the home page if an appointment is saved successfully' do
      post appointments_path, params: params
      expect(response).to redirect_to :root
      follow_redirect!
    end
    it 'should render the new template if the appointment isn\'t saved' do
      post appointments_path, params: faulty_params
      expect(response).to render_template :new
    end
  end

  describe 'edit' do
    let!(:appointment) do
      create :appointment, doctor_id: doctor.id, patient_id: patient.id
    end
    describe 'GET #edit' do
      it 'should render the edit template' do
        get edit_appointment_path(appointment.id)
        expect(response).to render_template :edit
      end
    end
    describe 'PUT #update' do
      it 'should redirect to the home page if update is successful' do
        put appointment_path(appointment.id), params: params
        expect(response).to redirect_to :root
        follow_redirect!
      end
      it 'should render the edit template if the edit isn\'t successful' do
        put appointment_path(appointment.id), params: faulty_params
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:appointment) do
      create :appointment, doctor_id: doctor.id, patient_id: patient.id
    end
    it 'should remove the appointment from the database' do
      expect {
        delete appointment_path(appointment.id)
      # appointment.should_not exist_in_database
    }.to change(Appointment, :count).by(-1)
    end
  end
end
