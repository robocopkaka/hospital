class Patient < ApplicationRecord
  include EmailValidation
  has_many :appointments
  has_many :doctors, through: :appointments
  validates_presence_of :name, :email
  validates_uniqueness_of :email
  validates :email, format: { with: EmailValidation::REGEX }
end
