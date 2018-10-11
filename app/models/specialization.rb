class Specialization < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  has_many :doctors
end
