class Board < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { minimum: 2, maximum: 100  }
  validates :name, format: { with: /\A(?!\@)/ }

  validates :description, presence: true
  validates :description, length: { minimum: 2 }
  validates :description, uniqueness: true

  validate :validate_name_and_description_length

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  belongs_to :user , optional: true
  # belongs_to :genre, optional: true
  
  def display_created_at
    I18n.l(self.created_at, format: :default)
  end

  def author_name
    user.display_name
  end

end
