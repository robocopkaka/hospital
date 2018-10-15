# frozen_string_literal: true

# Migration to add an admin and a specialization column to doctors table
class AddAdminAndSpecializationToDoctors < ActiveRecord::Migration[5.2]
  def up
    add_column :doctors, :admin, :boolean, default: false
  end

  def down
    remove_column :doctors, :admin
  end
end
