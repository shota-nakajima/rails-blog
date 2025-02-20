class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :article

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
