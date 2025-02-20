class Article < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
  validates :user_id, presence: true

  def self.search(search)
    if search
      Article.where(['title LIKE ? OR body LIKE ?', "%#{search}%", "%#{search}%"])
    else
      Article.all
    end
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
