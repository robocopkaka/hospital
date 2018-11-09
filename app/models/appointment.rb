# frozen_string_literal: true

# Appointment model
class Appointment < ApplicationRecord
  enum status: {
    pending: 'pending',
    confirmed: 'confirmed',
    declined: 'declined'
  }
  before_validation :set_default_doctor_id
  belongs_to :doctor
  belongs_to :patient
  belongs_to :specialization

  validates_presence_of :appointment_date
  validate :date_in_future

  # this method sets a default doctor_id before saving an appointment
  # the doctor_id doesn't allow null values so an actual value has to be set
  # the default id comes from the first hit on a search of a doctor who is
  # an admin
  def set_default_doctor_id
    return unless doctor_id.nil?
    self.doctor_id = Doctor.find_by(admin: true).id || 0
  end

  def date_in_future
    return if appointment_date && appointment_date > Date.today
    errors.add(
      :date_in_future, 'Date must be at least a day after current date'
    )
  end
end
