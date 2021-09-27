class Merchant < ApplicationRecord
  has_many :bulk_discounts
  has_many :items, dependent: :destroy
  has_many :invoices, through: :items
  validates :name, presence: true

  enum status: [:disabled, :enabled]

  def ready_to_ship
    items.select(:name, 'invoice_items.invoice_id', 'invoice_items.created_at AS invoice_created')
         .joins(:invoice_items)
         .where.not('invoice_items.status = ?', 2)
         .order("invoice_created")
  end

  def self.top_5_by_rev
    joins(invoices: :transactions)
    .where('transactions.result = ?', 1)
    .select('merchants.*, SUM(invoice_items.unit_price*invoice_items.quantity) AS total_rev')
    .group(:id)
    .order(total_rev: :desc)
    .limit(5)
  end

  def top_items
    items.joins( invoices: :transactions ).where(transactions: {result: 1})
      .group(:id)
      .select('items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total')
      .order('total DESC')
      .limit(5)
  end

  def best_day
    items.joins(:invoices)
    .select('invoices.*, SUM(invoice_items.unit_price*invoice_items.quantity) AS total_rev, invoices.updated_at AS top_date')
    .group('invoices.id')
    .order('invoices.updated_at DESC')
    .limit(1)
  end
end
