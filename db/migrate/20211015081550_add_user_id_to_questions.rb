class AddUserIdToQuestions < ActiveRecord::Migration[6.1]
  def up
    add_reference :questions, :user, null: false, index: true
  end

  def down
    remove_reference :questions, :user, index: true
  end
end
