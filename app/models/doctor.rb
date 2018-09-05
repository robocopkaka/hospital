class Doctor < ApplicationRecord
  include EmailValidation
  validates_presence_of :name, :email
  validates :email, format: { with: EmailValidation::REGEX }
end
