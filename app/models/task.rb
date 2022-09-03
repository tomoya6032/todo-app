class Task < ApplicationRecord
  belongs_to :board
  validates :title, :content, presence: true

  # def author_name
  #   user.display_name
  # end
end
