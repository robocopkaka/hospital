# frozen_string_literal: true

# Appointment model
class Appointment < ApplicationRecord
  before_validation :set_default_doctor_id
  belongs_to :doctor
  belongs_to :patient

  validates_presence_of :appointment_date

  def set_default_doctor_id
    return unless doctor_id.nil?
    self.doctor_id = Doctor.find_by(admin: true).id || 0
  end
end
