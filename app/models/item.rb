class Item < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_one_attached :image
  validates :name, presence: true
  validates :category, presence: true
end
