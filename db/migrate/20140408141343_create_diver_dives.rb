class CreateDiverDives < ActiveRecord::Migration
  def change
    create_table :diver_dives do |t|
      t.integer :diver_id
      t.integer :dive_id

      t.timestamps
    end
  end
end
