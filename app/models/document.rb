class Document < ApplicationRecord
  has_one :task
  has_one_attached :image
  validates :name, presence: true, uniqueness: true
  validates :image, presence: true
  accepts_nested_attributes_for :task
end
