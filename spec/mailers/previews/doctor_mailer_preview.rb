# Preview all emails at http://localhost:3000/rails/mailers/doctor_mailer
class DoctorMailerPreview < ActionMailer::Preview
  def update_password
    DoctorMailer.with(doctor: Doctor.last).update_password
  end

end
