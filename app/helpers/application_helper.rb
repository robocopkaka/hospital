module ApplicationHelper
  def signed_in?
    patient_signed_in? || doctor_signed_in?
  end
end
