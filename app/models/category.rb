class Category < ApplicationRecord
  has_ancestry
  has_many :question_categories, dependent: :destroy
  has_many :question, through: :question_categories
end
