class AddSpecializationIdToAppointments < ActiveRecord::Migration[5.2]
  def change
    add_reference :appointments, :specialization, foreign_key: true
  end
end
