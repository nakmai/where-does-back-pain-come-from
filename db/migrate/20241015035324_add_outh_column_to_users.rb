class AddOuthColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    unless column_exists?(:users, :provider)
      add_column :users, :provider, :string
    end
    
    unless column_exists?(:users, :uid)
      add_column :users, :uid, :string
    end
  end
end
