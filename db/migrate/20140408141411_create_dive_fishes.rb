class CreateDiveFishes < ActiveRecord::Migration
  def change
    create_table :dive_fishes do |t|
      t.integer :dive_id
      t.integer :fish_id

      t.timestamps
    end
  end
end
