class Comment < ApplicationRecord
  belongs_to :task
  belongs_to :user
  has_one_attached :avatar
  validates :content,presence: true
end
