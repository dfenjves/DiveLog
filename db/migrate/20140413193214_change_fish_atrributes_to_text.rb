class ChangeFishAtrributesToText < ActiveRecord::Migration
  def change
    change_column :fish, :wiki_link, :text
    change_column :fish, :picture_link, :text
  end
end
