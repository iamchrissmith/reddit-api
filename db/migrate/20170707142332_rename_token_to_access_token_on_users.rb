class RenameTokenToAccessTokenOnUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :token, :access_token
  end
end
