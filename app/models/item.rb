class Item < ApplicationRecord
  validates :name, :description, :unit_price, presence: true
  
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  enum status: [:disabled, :enabled]

  def price_dollars(quantity = 1)
    '%.2f' % (unit_price * quantity / 100.0)
  end

  def unit_price_dollars
    "%.2f" % (unit_price / 100.0)
  end

  def pennies_to_dollars
    total / 100.0
  end

  def best_day
    invoices.joins(:invoice_items, :transactions)
      .where(transactions: {result: 'success'})
      .select('invoices.created_at, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .group('invoices.created_at')
      .order('revenue DESC, invoices.created_at DESC')
      .first
      .created_at
  end
end
