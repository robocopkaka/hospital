class AppointmentMailer < ApplicationMailer
  default from: 'notifications@andela.com'

  def new_appointment
    doctors = Doctor.where(admin: true).pluck(:email)
    @appointment = params[:appointment]
    @patient = @appointment.patient.name
    @specialization = @appointment.specialization.name
    mail(to: doctors, subject: 'A patient just made a new appointment')
  end
end
