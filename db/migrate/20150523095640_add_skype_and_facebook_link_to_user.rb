class AddSkypeAndFacebookLinkToUser < ActiveRecord::Migration
  def change
    add_column :users, :skype_username, :string
    add_column :users, :facebook_username, :string
  end
end
