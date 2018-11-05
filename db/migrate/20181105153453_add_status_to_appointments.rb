class AddStatusToAppointments < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      CREATE TYPE status AS ENUM ('pending', 'confirmed', 'declined');
    SQL
    add_column :appointments, :status, :status, index: true, default: 'pending'
  end

  def down
    remove_column :appointments, :status

    execute <<-SQL
      DROP TYPE status;
    SQL
  end
end
