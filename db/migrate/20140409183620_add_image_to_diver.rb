class AddImageToDiver < ActiveRecord::Migration
  def change
    add_column :divers, :image, :string
  end
end
