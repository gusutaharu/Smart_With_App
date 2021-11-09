class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
  has_many :questions, dependent: :destroy
  mount_uploader :user_icon, UserIconUploader
  validates :name, presence: true, length: { maximum: 20 }
end
