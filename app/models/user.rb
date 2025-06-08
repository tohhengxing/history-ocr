class User < ApplicationRecord
  has_secure_password

  enum :role, { admin: 0, user: 1 }

  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }
end
