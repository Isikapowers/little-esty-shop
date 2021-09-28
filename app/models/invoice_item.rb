class InvoiceItem < ApplicationRecord
  validates :quantity, :unit_price, :status, :created_at, :updated_at, presence: true

  belongs_to :item
  belongs_to :invoice
  has_one :merchant, through: :item
  has_many :bulk_discounts, through: :merchant

  enum status: [:pending, :packaged, :shipped]

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end

  def self.on_merchant_invoice(invoice_id, merchant_id)
    invoice = Invoice.find(invoice_id)
    InvoiceItem.where(item_id: invoice.items.where(merchant_id: merchant_id), invoice_id: invoice_id)
               .order(:item_id)
  end

  def self.total_rev
    pennies = self.sum("unit_price * quantity")
    '%.2f' % (pennies / 100.0)
  end

  def get_item
    Item.find(item_id)
  end

  def price_dollars(mult = 1)
    '%.2f' % (unit_price * mult / 100.0)
  end

  def applicable_discount
    bulk_discounts.where("? >= quantity", self.quantity)
                  .order(percentage: :desc, quantity: :desc)
                  .pluck(:percentage, :id)
                  .first
  end

  def revenue
    if applicable_discount.blank?
      (unit_price * quantity) / 100.0
    else
      revenue = (unit_price * quantity) / 100.0
      revenue - (revenue * (applicable_discount.first) / 100.0)
    end
  end
end
