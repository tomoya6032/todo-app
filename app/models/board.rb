class Board < ApplicationRecord
  has_one_attached :eyecatch
  validates :title, presence: true
  validates :title, length: { minimum: 2, maximum: 100  }
  validates :title, format: { with: /\A(?!\@)/ }

  validates :description, presence: true
  validates :description, length: { minimum: 2 }
  validates :description, uniqueness: true

  has_many :comments, dependent: :destroy
  has_many :tasks, dependent: :destroy

  belongs_to :user, optional: true
  # belongs_to :genre, optional: true


  def display_created_at
    I18n.l(self.created_at, format: :default)
  end



  def author_name
    user.display_name
  end

end
