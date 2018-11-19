class Doctor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include EmailValidation
  has_many :appointments
  has_many :patients, through: :appointments
  belongs_to :specialization
  validates_presence_of :name, :email
  validates :email, format: { with: EmailValidation::REGEX }
  def self.fetch_admin
    Doctor.where(admin: true).first
  end
end
