class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
  has_many :questions, dependent: :destroy
  validates :name, presence: true, length: { maximum: 20 }
end
