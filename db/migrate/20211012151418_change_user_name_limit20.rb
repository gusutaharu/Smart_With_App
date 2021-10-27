class ChangeUserNameLimit20 < ActiveRecord::Migration[6.1]
  def up
    change_column :users, :name, :string, limit: 20
  end
  def down
    change_column :users, :name, :string
  end
end
