class RemoveTokenAttributeFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :token, :string
  end
end
