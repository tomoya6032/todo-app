class Task < ApplicationRecord
  belongs_to :board
  belongs_to :user
  validates :title, :content, presence: true

  def display_at
    I18n.l(self.deadline_at, format: :default)
  end

  def author_name
    user.display_name
  end

  
end
