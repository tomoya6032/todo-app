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

  
end
