class Admin < ApplicationRecord
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { maximum: 20 }
end
