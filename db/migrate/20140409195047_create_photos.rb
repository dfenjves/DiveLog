class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :dive_id
      t.string :image

      t.timestamps
    end
  end
end
