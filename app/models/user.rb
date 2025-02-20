class User < ApplicationRecord
  has_many :articles
  has_many :favorites, dependent: :destroy
  has_secure_password
  has_one_attached :avatar
  validate :acceptable_avatar

  def acceptable_avatar
    return unless avatar.attached?

    unless avatar.blob.byte_size <= 1.megabyte
      errors.add(:avatar, "は1MB以下にしてください")
    end

    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(avatar.content_type)
      errors.add(:avatar, "はJPEGまたはPNG形式にしてください")
    end
  end

  validates :name, presence: true, length: {minimum:2, maximum:32}
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, format: {with: /^[0-9a-zA-Z]+$/, multiline: true}
end
