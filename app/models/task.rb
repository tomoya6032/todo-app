# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  content     :text             not null
#  deadline_at :datetime
#  limit       :integer
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  board_id    :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_tasks_on_board_id  (board_id)
#  index_tasks_on_user_id   (user_id)
#
class Task < ApplicationRecord
  has_one_attached :eyecatch
  has_one_attached :avatar
  belongs_to :board
  belongs_to :user
  validates :title, :content, presence: true
  has_many :comments, dependent: :destroy

  def display_created_at
    I18n.l(self.created_at, format: :default)
  end

  # def display_deadline_at
  #   I18n.l(self.created_at, format: :default)
  # end

  # def display_datetime
  #   I18n.l(self.datetime_at, format: :default)
  # end

  # def has_written?(task)
  #   tasks.exists?(board_id: task.id)
  # end

  def author_name
    user.display_name
  end

  def comment_count
    comments.count
  end

  def avatar_image
    if profile&.avatar&.attached?
      profile.avatar
    else
      'default-avatar.png'
    end
  end



end
