class RemoveColumn < ActiveRecord::Migration
  def change
    remove_column :users, :card_type, :string
  end
end
