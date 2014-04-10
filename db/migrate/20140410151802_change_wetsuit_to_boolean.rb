class ChangeWetsuitToBoolean < ActiveRecord::Migration
  def change
    change_column :dives, :wetsuit, :boolean
  end
end
