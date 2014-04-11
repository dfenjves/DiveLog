class AddOperatorToDive < ActiveRecord::Migration
  def change
    add_column :dives, :operator_id, :integer
  end
end
