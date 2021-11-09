class AddQuestionImagesToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :question_images, :json
  end
end
