# frozen_string_literal: true

# All generic helpers go here
module ApplicationHelper
  def signed_in?
    patient_signed_in? || doctor_signed_in?
  end

  def patient_or_doctor
    if !current_doctor.nil?
      # render stuff
      content_tag(:a, 'Doctors',
                  href: doctors_url, class: 'item', id: 'doctors')
    elsif !current_patient.nil?
      # render some other stuff
      content_tag(:a, 'Patients',
                  href: patients_url, class: 'item', id: 'patients')
    end
  end
end
