class Task < ApplicationRecord
  has_one_attached :eyecatch
  belongs_to :board
  belongs_to :user
  validates :title, :content, presence: true

  def display_datetime
    I18n.l(self.datetime_at, format: :default)
  end

  def author_name
    user.display_name
  end

  
end
