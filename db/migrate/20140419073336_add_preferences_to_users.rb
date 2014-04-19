class AddPreferencesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bedrooms, :integer
    add_column :users, :min_price, :integer
    add_column :users, :max_price, :integer
    add_column :users, :intro, :text
  end
end
