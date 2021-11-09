class Question < ApplicationRecord
  IMAGES_NUMBER_LIMIT = 4
  belongs_to :user
  mount_uploaders :question_images, QuestionImagesUploader
  validates :title, presence: true, length: { maximum: 20 }
  validates :information, presence: true
  validates :content, presence: true
  validates :user_id, presence: true
  validate :validate_number_of_images

  private

  def validate_number_of_images
    return if question_images.length <= IMAGES_NUMBER_LIMIT
    errors.add(:question, "に添付できる画像は#{IMAGES_NUMBER_LIMIT}件までです")
  end
end
