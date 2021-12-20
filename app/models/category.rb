class Category < ApplicationRecord
  has_ancestry
  has_many :question_categories, dependent: :destroy
  has_many :questions, through: :question_categories
end
