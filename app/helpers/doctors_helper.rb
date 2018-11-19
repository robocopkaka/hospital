# frozen_string_literal: true

# Helper methods for the DoctorsController and Doctors views
module DoctorsHelper
  def doctor_has_appointments?(doctor)
    return false if doctor.appointments.count.zero?
    true
  end

  def reassign_appointments(doctor)
    appointments = doctor.appointments
    admin = Doctor.fetch_admin

    appointments.each do |appointment|
      patient = appointment.patient
      # appointment.status = 'pending'
      # appointment.doctor_id = admin.id
      # appointment.save!
      appointment.update_attributes(status: 'pending', doctor_id: admin.id)

      # mailers
      if appointment.confirmed?
        AppointmentMailer
          .with(patient: patient).change_of_doctor.deliver_later
      end
    end
  end
end
