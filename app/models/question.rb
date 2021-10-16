class Question < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 20 }
  validates :information, presence: true
  validates :content, presence: true
  validates :user_id, presence: true
end
