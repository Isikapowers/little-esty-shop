class BulkDiscount < ApplicationRecord
  validates :name, :percentage, :quantity, presence: true

  belongs_to :merchant
end
