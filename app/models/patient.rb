class Patient < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include EmailValidation
  has_many :appointments
  has_many :doctors, through: :appointments
  validates_presence_of :name, :email, :address
  validates_uniqueness_of :email
  validates :email, format: { with: EmailValidation::REGEX }
end
