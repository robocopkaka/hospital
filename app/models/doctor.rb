class Doctor < ApplicationRecord
  include EmailValidation
  has_many :appointments
  has_many :patients, through: :appointments
  validates_presence_of :name, :email
  validates :email, format: { with: EmailValidation::REGEX }
end
