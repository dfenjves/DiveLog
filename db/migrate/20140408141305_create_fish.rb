class CreateFish < ActiveRecord::Migration
  def change
    create_table :fish do |t|
      t.string :name
      t.string :color
      t.integer :length
      t.string :wiki_link
      t.string :picture_link

      t.timestamps
    end
  end
end
