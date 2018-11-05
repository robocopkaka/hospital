class RemoveConfirmedFromAppointments < ActiveRecord::Migration[5.2]
  def change
    remove_column :appointments, :confirmed, :boolean
  end
end
