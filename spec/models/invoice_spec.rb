require 'rails_helper'

RSpec.describe Invoice, type: :model do
  before :each do
    @joey = Customer.create!(first_name: "Joey", last_name: "Ondricka", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    @cecelia = Customer.create!(first_name: "Cecelia", last_name: "Osinski", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")
    @mariah = Customer.create!(first_name: "Mariah", last_name: "Toy", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")

    @invoice_1 = @joey.invoices.create!(customer_id: 1, status: "completed", created_at: "2012-03-13 16:54:10 UTC", updated_at: "2012-03-25 09:54:09 UTC")
    @invoice_2 = @cecelia.invoices.create!(customer_id: 2, status: "cancelled", created_at: "2012-03-07 12:54:10 UTC", updated_at: "2012-03-13 16:54:10 UTC")
    @invoice_3 = @mariah.invoices.create!(customer_id: 3, status: "in progress", created_at: "2012-03-06 21:54:10 UTC", updated_at: "2012-03-06 21:54:10 UTC")

    @zara = Merchant.create!(name: "Zara")
    @forever_21 = Merchant.create!(name: "Forever 21")

    @hat = @zara.items.create!(name: "Hat", description: "Sun hat", unit_price: 1200, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @socks = @zara.items.create!(name: "Socks", description: "Heart pattern socks", unit_price: 600, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @tank_top = @zara.items.create!(name: "Tank top", description: "Work out tank top", unit_price: 1800, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @shorts = @forever_21.items.create!(name: "Shorts", description: "Black denim shorts", unit_price: 4000, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @dress = @forever_21.items.create!(name: "Dress", description: "Sun dress", unit_price: 2900, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @skirt = @forever_21.items.create!(name: "Skirt", description: "Polka dot skirt", unit_price: 2500, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")

    @invoice_item_1 = InvoiceItem.create!(item: @hat, invoice: @invoice_1, quantity: 2, unit_price: 1200, status: "pending", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @invoice_item_2 = InvoiceItem.create!(item: @socks, invoice: @invoice_1 , quantity: 2, unit_price: 600, status: "pending", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @invoice_item_3 = InvoiceItem.create!(item: @tank_top , invoice: @invoice_2, quantity: 1 , unit_price: 1800, status: "shipped", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @invoice_item_4 = InvoiceItem.create!(item: @shorts, invoice: @invoice_3  , quantity: 1 , unit_price: 4000, status: "shipped", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @invoice_item_5 = InvoiceItem.create!(item: @dress, invoice: @invoice_3, quantity: 5, unit_price: 2900, status: "packaged", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @invoice_item_6 = InvoiceItem.create!(item: @skirt, invoice: @invoice_3, quantity: 3, unit_price: 2500, status: "packaged", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
  end

  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:created_at) }
    it { should validate_presence_of(:updated_at) }
  end

  describe "#instance methods" do
    it "can gererate a total revenue" do
      expect(@invoice_1.total_revenue).to eq(3600)
    end
  end
end
