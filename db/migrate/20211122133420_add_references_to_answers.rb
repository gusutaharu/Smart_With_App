class AddReferencesToAnswers < ActiveRecord::Migration[6.1]
  def change
    add_reference :answers, :parent, foreign_key: { to_table: :answers }
  end
end
