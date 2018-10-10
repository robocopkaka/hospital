# frozen_string_literal: true

# Migration to add an admin and a specialization column to doctors table
class AddAdminAndSpecializationToDoctors < ActiveRecord::Migration[5.2]
  def up
    add_column :doctors, :admin, :boolean, default: false
    add_column :doctors, :specialization, :string, default: ''
  end

  def down
    remove_column :doctors, :admin
    remove_column :doctors, :specialization
  end
end
