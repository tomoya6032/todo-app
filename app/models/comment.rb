class Comment < ApplicationRecord
  belongs_to :task
  belongs_to :user
  has_one_attached :avatar
  validates :content,presence: true

  # def avatar_image
  #   if comment&.avatar&.attached?
  #     comment.avatar
  #   else
  #     'default-avatar.png'
  #   end
  # end

end
