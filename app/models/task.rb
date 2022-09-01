class Task < ApplicationRecord
  belongs_to :board
  validates :title, :content, presence: true
end
