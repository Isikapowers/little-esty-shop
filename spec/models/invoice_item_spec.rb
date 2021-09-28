require 'rails_helper'

RSpec.describe InvoiceItem do
  before :each do
    @joey = Customer.create!(first_name: "Joey", last_name: "Ondricka", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    @cecelia = Customer.create!(first_name: "Cecelia", last_name: "Osinski", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")
    @mariah = Customer.create!(first_name: "Mariah", last_name: "Toy", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")
    @donna = Customer.create!(first_name: "Donna", last_name: "Dumdooko", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")
    @christ = Customer.create!(first_name: "Christ", last_name: "Hough", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")
    @amy = Customer.create!(first_name: "Amy", last_name: "Hollerway", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")

    @invoice_1 = @joey.invoices.create!(customer_id: 1, status: "completed", created_at: "2012-03-13 16:54:10 UTC", updated_at: "2012-03-25 09:54:09 UTC")
    @invoice_2 = @cecelia.invoices.create!(customer_id: 2, status: "completed", created_at: "2012-03-07 12:54:10 UTC", updated_at: "2012-03-13 16:54:10 UTC")
    @invoice_3 = @mariah.invoices.create!(customer_id: 3, status: "in progress", created_at: "2012-03-06 21:54:10 UTC", updated_at: "2012-03-06 21:54:10 UTC")
    @invoice_4 = @donna.invoices.create!(customer_id: 4, status: "completed", created_at: "2012-03-13 16:54:10 UTC", updated_at: "2012-03-25 09:54:09 UTC")
    @invoice_5 = @christ.invoices.create!(customer_id: 5, status: "completed", created_at: "2012-03-07 12:54:10 UTC", updated_at: "2012-03-13 16:54:10 UTC")
    @invoice_6 = @amy.invoices.create!(customer_id: 6, status: "in progress", created_at: "2012-03-06 21:54:10 UTC", updated_at: "2012-03-06 21:54:10 UTC")

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
    @invoice_item_7 = InvoiceItem.create!(item: @tank_top , invoice: @invoice_4, quantity: 1 , unit_price: 1800, status: "shipped", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @invoice_item_8 = InvoiceItem.create!(item: @shorts, invoice: @invoice_5  , quantity: 1 , unit_price: 4000, status: "shipped", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @invoice_item_9 = InvoiceItem.create!(item: @dress, invoice: @invoice_5, quantity: 5, unit_price: 2900, status: "packaged", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @invoice_item_10 = InvoiceItem.create!(item: @skirt, invoice: @invoice_6, quantity: 3, unit_price: 2500, status: "packaged", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")

    Transaction.create!(invoice_id: @invoice_1.id, credit_card_number: "4654405418249632", result: "success", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    Transaction.create!(invoice_id: @invoice_2.id, credit_card_number: "4580251236515201", result: "success", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    Transaction.create!(invoice_id: @invoice_3.id, credit_card_number: "4354495077693036", result: "success", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")
    Transaction.create!(invoice_id: @invoice_4.id, credit_card_number: "4515551623735607", result: "success", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")
    Transaction.create!(invoice_id: @invoice_5.id, credit_card_number: "4844518708741275", result: "success", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")
    Transaction.create!(invoice_id: @invoice_6.id, credit_card_number: "4203696133194408", result: "success", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")

    @merch = create(:merchant)
    @merch2 = create(:merchant)
    @item1 = create(:item, merchant_id: @merch.id)
    @item2 = create(:item, merchant_id: @merch.id)
    @item3 = create(:item, merchant_id: @merch2.id)
    @cust = create(:customer)
    @invoice1 = create(:invoice, customer_id: @cust.id)
    @inv_item1 = create(:invoice_item, unit_price: @item1.unit_price, invoice_id: @invoice1.id, item_id: @item1.id)
    @inv_item2 = create(:invoice_item, unit_price: @item2.unit_price, invoice_id: @invoice1.id, item_id: @item2.id)
    @inv_item3 = create(:invoice_item, unit_price: @item2.unit_price, invoice_id: @invoice1.id, item_id: @item3.id)

    @discount1 = @merch.bulk_discounts.create!(name: "10% off on 10", percentage: 10, quantity: 10)
    # @discount2 = @merch.bulk_discounts.create!(name: "20% off on 20", percentage: 20, quantity: 20)
  end

  describe 'relationships' do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
    it { should have_many(:bulk_discounts).through(:merchant) }
    it { should have_one(:merchant).through(:item) }
  end

  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:created_at) }
    it { should validate_presence_of(:updated_at) }
  end


  describe ".incomplete_invoices" do
    it "can display incomplete invoices with items that have not been shipped" do
      expect(InvoiceItem.incomplete_invoices).to eq([@invoice_3, @invoice_6, @invoice_5, @invoice_1, @invoice1])
    end
  end

  describe 'class methods' do
    describe '#on_merchant_invoice' do
      it 'returns all invoice items with given invoice and merchant id' do
        expect(InvoiceItem.on_merchant_invoice(@invoice1.id, @merch.id)).to eq([@inv_item1, @inv_item2])
        expect(InvoiceItem.on_merchant_invoice(@invoice1.id, @merch2.id)).to eq([@inv_item3])
      end
    end

    describe '#total_rev' do
      it 'returns the total revenue' do
        @inv_item1.update(quantity: 2)
        @inv_item2.update(quantity: 2)
        @inv_item3.update(quantity: 2)
        @inv_item1.update(unit_price:  50)
        @inv_item2.update(unit_price:  25)
        @inv_item3.update(unit_price:  75)

        expect(InvoiceItem.total_rev).to eq('595.00')
      end
    end
  end

  describe 'instance methods' do
    describe '.get_item' do
      it 'returns the item on the invoice' do
        expect(@inv_item1.get_item).to eq(@item1)
        expect(@inv_item2.get_item).to eq(@item2)
        expect(@inv_item3.get_item).to eq(@item3)
      end
    end

    describe '.price_dollars' do
      it "return the unit price * quantity formatted in dollars" do
        @inv_item1.unit_price = 3330
        expect(@inv_item1.price_dollars).to eq('33.30')
        expect(@inv_item1.price_dollars(2)).to eq('66.60')
      end
    end

    describe "applicable_discount" do
      it "can find a discount" do
        expect(@inv_item1.applicable_discount.first).to eq(10)
      end

      it "can calculate discount revenue" do
        @inv_item1.update(quantity: 10)
        @inv_item1.update(unit_price: 2000)

        expect(@inv_item1.revenue).to eq(180)
      end
    end
  end
end
