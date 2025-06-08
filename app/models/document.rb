class Document < ApplicationRecord
  has_one_attached :image
  validates :name, presence: true, uniqueness: true
  validates :image, presence: true
end
