class AddStatusToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :status, :integer, default: 1, null: false, limit: 1
  end
end
