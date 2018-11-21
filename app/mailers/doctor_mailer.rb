class DoctorMailer < ApplicationMailer
  default from: 'hospital@kachirocks.com'

  def update_password
    @doctor = params[:doctor]
    mail(to: @doctor.email, subject: 'Update your password')
  end
end
