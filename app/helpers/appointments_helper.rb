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

  def logged_in_user
    @logged_in_user = current_doctor || current_patient
  end

  def group_appointments(appointments, appointments_hash)
    appointments.group_by do |appointment|
      if appointment.appointment_date.past?
        appointments_hash[:past_appointments] << appointment
      elsif appointment.appointment_date.future?
        appointments_hash[:future_appointments] << appointment
      end
    end
    appointments_hash[:past_appointments] = appointments_hash[:past_appointments]
                                            .paginate(page: params[:page],
                                                      per_page: 2)
    appointments_hash[:future_appointments] = appointments_hash[:future_appointments]
                                              .paginate(page: params[:page],
                                                        per_page: 2)
    appointments_hash
  end
end
