class Post < ApplicationRecord
  belongs_to :user
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, presence: true, length: { minimum: 6, maximum: 100 }
  validates :description, presence: true,  length: { minimum: 10, maximum: 300 }
end
