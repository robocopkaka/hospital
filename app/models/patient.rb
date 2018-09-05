class Patient < ApplicationRecord
  include EmailValidation
  validates_presence_of :name, :email
  validates_uniqueness_of :email
  validates :email, format: { with: EmailValidation::REGEX }
end
