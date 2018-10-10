module AppointmentsHelper
  def get_specializations
    Doctor.all.pluck(:specialization)
  end
end
