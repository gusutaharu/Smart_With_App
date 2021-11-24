class ApplicationRecord < ActiveRecord::Base
  scope :recent, -> { order(created_at: :desc) }
  self.abstract_class = true
end
