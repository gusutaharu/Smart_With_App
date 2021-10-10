class Question < ApplicationRecord
  validates :title, presence: true, length: { maximum: 20 }
  validates :information, presence: true
  validates :content, presence: true
end
