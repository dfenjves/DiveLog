class ChangeWetsuitToBoolean < ActiveRecord::Migration
  def change
    add_column :dives, :new_wetsuit, :boolean
    remove_column :dives, :wetsuit
    rename_column :dives, :new_wetsuit, :wetsuit
  end
end
