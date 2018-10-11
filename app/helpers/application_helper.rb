# frozen_string_literal: true

# All generic helpers go here
module ApplicationHelper
  def signed_in?
    patient_signed_in? || doctor_signed_in?
  end

  def patient_or_doctor
    if !current_doctor.nil?
      # render stuff
      build_doctor_links(current_doctor)
    elsif !current_patient.nil?
      # render some other stuff
      content_tag(:a, 'Patients',
                  href: patients_url, class: 'item', id: 'patients')
    end
  end

  def build_doctor_links(doctor)
    content = content_tag(:a, 'Doctors',
                          href: doctors_url, class: 'item', id: 'doctors')
    return unless doctor.admin?
    content << build_specialization_links
  end

  def build_specialization_links
    content_tag(:div, class: %w[ui dropdown item]) do
      concat 'Specializations'
      concat content_tag(:i, '', class: %w[dropdown icon])
      concat build_specialization_dropdown_items
    end
  end

  def build_specialization_dropdown_items
    content_tag(:div, class: 'menu') do
      links = content_tag(:a, 'Add Specialization',
                          href: new_specialization_url, class: 'item',
                          id: 'specializations')
      links << content_tag(:a, 'Specializations', href: specializations_url,
                                                  class: 'item',
                                                  id: 'specializations')
    end
  end
end
