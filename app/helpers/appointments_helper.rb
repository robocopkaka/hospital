# frozen_string_literal: true

# Helpers for Appointments controllers and views
module AppointmentsHelper
  def retrieve_specializations
    Specialization.joins(:doctors).order(name: :asc).uniq
  end

  def get_doctors_by_specialization(specialization_id)
    Doctor.where(specialization_id: specialization_id)
  end

  def confirm_appointment(appointment)
    appointment.update_attributes(confirmed: true)
    AppointmentMailer.with(appointment: @appointment)
                     .confirm_appointment.deliver_later
  end
end
