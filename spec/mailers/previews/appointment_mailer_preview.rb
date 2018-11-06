# Preview all emails at http://localhost:3000/rails/mailers/appointment_mailer
class AppointmentMailerPreview < ActionMailer::Preview
  def new_appointment
    AppointmentMailer.with(appointment: Appointment.last).new_appointment
  end

  def confirm_appointment
    AppointmentMailer.with(appointment: Appointment.last).confirm_appointment
  end

  def decline_appointment
    AppointmentMailer.with(appointment: Appointment.last).decline_appointment
  end
end
