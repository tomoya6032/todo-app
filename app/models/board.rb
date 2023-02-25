# == Schema Information
#
# Table name: boards
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_boards_on_user_id  (user_id)
#
class Board < ApplicationRecord
  has_one_attached :eyecatch
  has_rich_text :description
  validates :title, presence: true
  validates :title, length: { minimum: 2, maximum: 100  }
  validates :title, format: { with: /\A(?!\@)/ }

  # validates :description, presence: true
  # validates :description, length: { minimum: 2 }
  # validates :description, uniqueness: true

  has_many :comments, dependent: :destroy
  has_many :tasks, dependent: :destroy

  belongs_to :user, optional: true
  # belongs_to :genre, optional: true


  

  def avatar_image
    if profile&.avatar&.attached?
      profile.avatar
    else
      'default-avatar.png'
    end
  end

  # def comment_image
  #   if profile&.avatar&.attached?
  #     profile.avatar
  #   else
  #     'default-avatar.png'
  #   end
  # end

end
