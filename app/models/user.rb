# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :boards, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :followings, through: :following_relationships, source: :following

  has_many :follower_relationships, foreign_key: 'following_id', class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower

  has_one :profile, dependent: :destroy
  has_one_attached :avatar
  

  def has_written?(board)
    boards.exists?(id: board.id)
  end

  def has_written2?(task)
    tasks.exists?(id: task.id)
  end

  # def has_written3?(comment)
  #   comments.exists?(id: comment.id)
  # end

  

  def follow!(user)
    # if user.is_a?(User)
    #   user_id = user.id
    # else
    #   user_id = user
    # end  
    user_id = get_user_id(user)
    following_relationships.create!(following_id: user_id)
  end

  def unfollow!(user)
    # if user.is_a?(User)
    #   user_id = user.id
    # else
    #   user_id = user
    # end  
    user_id = get_user_id(user)
    relation = following_relationships.find_by!(following_id: user_id)
    relation.destroy!
  end

  def has_followed?(user)
    following_relationships.exists?(following_id: user.id)
  end


  def prepare_profile
    profile || build_profile
  end

  

  private
  def get_user_id(user)
    if user.is_a?(User)
      # user_id = user.id
       user.id
    else
      # user_id = user
       user
    end  
  end  

end
