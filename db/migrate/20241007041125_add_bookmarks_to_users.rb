class AddBookmarksToUsers < ActiveRecord::Migration[7.0]
  def change
    def change
      add_column :users, :bookmarks, :text, array: true, default: []
    end
  end
end
