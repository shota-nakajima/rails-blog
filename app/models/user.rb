class User < ApplicationRecord
  has_many :articles

  has_secure_password

  validates :name, presence: true, length: {minimum:2, maximum:32}
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, format: {with: /^[0-9a-zA-Z]+$/, multiline: true}
end
