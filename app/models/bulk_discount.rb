class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  has_many :items, through: :merchant
  validates :percent_discount, :threshold, presence: true
  validates :percent_discount, :threshold, numericality: true
end
