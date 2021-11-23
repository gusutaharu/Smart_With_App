class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  belongs_to :parent, class_name: "Answer", optional: true
  has_many :replies, class_name: "Answer", foreign_key: :parent_id, dependent: :destroy
  mount_uploaders :images, AnswerImageUploader
  validates :content, presence: true
end
