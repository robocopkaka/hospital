module AppointmentsHelper
  def retrieve_specializations
    Specialization.all.order(name: :asc)
  end

  def get_doctors_by_specialization(specialization_id)
    Doctor.where(specialization_id: specialization_id)
  end
end
