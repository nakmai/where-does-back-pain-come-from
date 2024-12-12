# frozen_string_literal: true

class AddRegisteredPagesToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :registered_pages, :text
  end
end
