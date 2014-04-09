class AddFbToDivers < ActiveRecord::Migration
  def change
    add_column :divers, :provider, :string
    add_column :divers, :uid, :string
    add_column :divers, :oauth_token, :string
    add_column :divers, :oauth_expires_at, :datetime
  end
end