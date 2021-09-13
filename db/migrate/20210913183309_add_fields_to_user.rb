class AddFieldsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :invitation_accepted, :boolean, default: false
    add_column :users, :invitation_token, :string
    add_column :users, :invitation_expiration, :datetime
  end
end
