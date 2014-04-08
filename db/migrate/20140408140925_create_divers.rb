class CreateDivers < ActiveRecord::Migration
  def change
    create_table :divers do |t|
      t.string :name
      t.string :email
      t.date :birthday
      t.string :certification_level
      t.string :nationality

      t.timestamps
    end
  end
end
