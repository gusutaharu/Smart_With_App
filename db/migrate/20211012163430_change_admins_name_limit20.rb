class ChangeAdminsNameLimit20 < ActiveRecord::Migration[6.1]
  def up
    change_column :admins, :name, :string, limit: 20
  end
  def down
    change_column :admins, :name, :string
  end
end
