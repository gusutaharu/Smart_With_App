class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :title, limit: 20, null: false
      t.text :content, null: false
      t.text :information

      t.timestamps
    end
  end
end
