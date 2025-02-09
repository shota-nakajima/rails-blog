class Article < ApplicationRecord
  belongs_to :user

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
end
