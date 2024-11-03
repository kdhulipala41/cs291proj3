class AddUsernameToArticles < ActiveRecord::Migration[7.2]
  def change
    add_column :articles, :username, :string
  end
end
