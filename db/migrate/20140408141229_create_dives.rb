class CreateDives < ActiveRecord::Migration
  def change
    create_table :dives do |t|
      t.date :date
      t.integer :depth
      t.integer :temperature
      t.time :time_in
      t.time :time_out
      t.string :dive_site
      t.integer :visibility
      t.integer :start_air
      t.integer :end_air
      t.string :dive_type
      t.string :dive_activity
      t.string :wetsuit
      t.string :conditions
      t.text :notes

      t.timestamps
    end
  end
end
