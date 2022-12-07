class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :boards, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :profile, dependent: :destroy
  has_one :avatar
  

  def has_written?(board)
    boards.exists?(id: board.id)
  end

  def has_written2?(task)
    tasks.exists?(id: task.id)
  end

  # def has_written3?(comment)
  #   comments.exists?(id: comment.id)
  # end

  def display_name
    if profile && profile.nickname
      profile.nickname
    else  
      self.email.split('@').first
    end
  end

  def prepare_profile
    profile || build_profile
  end

  def avatar_image
    if profile&.avatar&.attached?
      profile.avatar
    else
      'default-avatar.png'
    end
  end

  # def comment_image
  #   if profile&.avatar&.attached?
  #     comment.avatar
  #   else
  #     'default-avatar.png'
  #   end
  # end

end
