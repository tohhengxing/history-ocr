class User < ApplicationRecord
  has_many :tasks
  has_secure_password

  enum :role, { admin: 0, user: 1 }, default: :user

  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }
end
