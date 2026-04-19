class User < ApplicationRecord
  has_many :participants, dependent: :destroy
  has_many :trips, through: :participants
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { minimum: 5, maximum: 50 }
  validates :email, presence: true, length: { minimum: 10, maximum: 100 },
            uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6, maximum: 20 }
  has_secure_password
end
