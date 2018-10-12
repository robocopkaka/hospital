module AppointmentsHelper
  def retrieve_specializations
    Specialization.all.order(name: :asc)
  end
end
