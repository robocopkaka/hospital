class AddPatientNotesAndConfirmedAndDoctorNotesToAppointments < ActiveRecord::Migration[5.2]
  def change
    add_column :appointments, :patient_notes, :text, default: '', null: false
    add_column :appointments, :doctor_notes, :text, default: '', null: false
    add_column :appointments, :confirmed, :boolean, default: false, null: false
  end
end
