class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  mount_uploaders :images, AnswerImageUploader
  validates :content, presence: true
end
