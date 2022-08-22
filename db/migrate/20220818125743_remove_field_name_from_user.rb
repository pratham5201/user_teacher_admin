class RemoveFieldNameFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :role1, :integer
  end
end
