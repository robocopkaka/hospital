class AppointmentMailer < ApplicationMailer
  default from: 'hospital@kachirocks.com'
  before_action :retrieve_admins, only: %i(new_appointment confirm_appointment)

  def new_appointment
    @appointment = params[:appointment]
    @patient = @appointment.patient.name
    @specialization = @appointment.specialization.name
    mail(to: @doctors, subject: 'A patient just made a new appointment')
  end

  def confirm_appointment
    @appointment = params[:appointment]
    @patient = @appointment.patient
    @doctor = @appointment.doctor
    mail(to: [@patient.email, @doctor.email],
         subject: 'Your appointment has just been confirmed')
  end

  def decline_appointment
    @appointment = params[:appointment]
    @patient = @appointment.patient.name
    @doctor = @appointment.doctor.name
    mail(to: @patient, subject: 'Your appointment has been declined')
  end

  def retrieve_admins
    @doctors = Doctor.where(admin: true).pluck(:email)
  end
end
