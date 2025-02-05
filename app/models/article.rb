class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  def self.search(search)
    if search
      Article.where(['title LIKE ? OR body LIKE ?', "%#{search}%", "%#{search}%"])
    else
      Article.all
    end
  end
end
