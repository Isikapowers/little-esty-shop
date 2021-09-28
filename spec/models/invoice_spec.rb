require 'rails_helper'

RSpec.describe Invoice, type: :model do

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

  describe "instance methods" do
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
    it "can gererate a total revenue" do
      expect(@invoice_1.total_revenue).to eq("36.00")
      expect(@invoice_2.total_revenue).to eq("18.00")
      expect(@invoice_3.total_revenue).to eq("260.00")
    end

    it "can return the invoice customers full name" do
      invoice4 = create(:invoice, customer_id: @joey.id)
      expect(invoice4.customer_name).to eq("Joey Ondricka")
    end
  end

  describe 'class methods' do
    before :each do
      @merch = create_list(:merchant, 7)

      @item1 = create(:item, merchant: @merch[0], status: 'enabled')
      @item2 = create(:item, merchant: @merch[0], status: 'enabled')
      @item3 = create(:item, merchant: @merch[0], status: 'disabled')
      @item4 = create(:item, merchant: @merch[1])
      @item5 = create(:item, merchant: @merch[2])
      @item6 = create(:item, merchant: @merch[3])
      @item7 = create(:item, merchant: @merch[4])
      @item8 = create(:item, merchant: @merch[5])
      @item9 = create(:item, merchant: @merch[6])
      @invoice = create(:invoice, updated_at: "2012-03-26 09:54:09")
      @invoice1 = create(:invoice, updated_at: "2012-03-25 09:54:09")
      @invoice2 = create(:invoice, updated_at: "2012-03-25 09:54:09")
      @invoice3 = create(:invoice, updated_at: "2012-03-25 09:54:09")
      @invoice4 = create(:invoice, updated_at: "2012-03-25 09:54:09")
      @invoice5 = create(:invoice, updated_at: "2012-03-25 09:54:09")
      @invoice6 = create(:invoice, updated_at: "2012-03-25 09:54:09")
      @invoice7 = create(:invoice, updated_at: "2012-03-25 09:54:09")
      @invoice8 = create(:invoice, updated_at: "2012-03-25 09:54:09")
      @inv_item1 = create(:invoice_item, invoice: @invoice, item: @item1, unit_price: 2000, quantity: 1)
      @inv_item2 = create(:packaged_invoice_item, invoice: @invoice, item: @item1, unit_price: 1000, quantity: 1)
      @inv_item3 = create(:invoice_item, invoice: @invoice1, item: @item2, unit_price: 1000, quantity: 1)
      @inv_item4 = create(:shipped_invoice_item, invoice: @invoice1, item: @item2, unit_price: 1000, quantity: 1)
      @inv_item5 = create(:invoice_item, invoice: @invoice2, item: @item4, unit_price: 1000, quantity: 1)
      @inv_item6 = create(:invoice_item, invoice: @invoice3, item: @item5, unit_price: 2000, quantity: 2)
      @inv_item7 = create(:invoice_item, invoice: @invoice4, item: @item6, unit_price: 3000, quantity: 1)
      @inv_item8 = create(:invoice_item, invoice: @invoice5, item: @item6, unit_price: 2500, quantity: 2)
      @inv_item9 = create(:invoice_item, invoice: @invoice5, item: @item7, unit_price: 1500, quantity: 2)
      @inv_item10 = create(:invoice_item, invoice: @invoice5, item: @item8, unit_price: 3500, quantity: 2)
      @inv_item11 = create(:invoice_item, invoice: @invoice6, item: @item9, unit_price: 3000, quantity: 3)
      @inv_item13 = create(:invoice_item, invoice: @invoice8, item: @item3, unit_price: 3000, quantity: 3)
      @transaction = create(:transaction, invoice: @invoice)
      @transaction2 = create(:transaction, invoice: @invoice1)
      @transaction3 = create(:transaction, invoice: @invoice2)
      @transaction4 = create(:transaction, invoice: @invoice3)
      @transaction5 = create(:transaction, invoice: @invoice4)
      @transaction6 = create(:transaction, invoice: @invoice5)
      @transaction7 = create(:failed_transaction, invoice: @invoice6)
      @transaction8 = create(:failed_transaction, invoice: @invoice4)

      @discount1 = @merch[0].bulk_discounts.create!(name: "10% off on 10", percentage: 10, quantity: 10)
      @discount2 = @merch[1].bulk_discounts.create!(name: "20% off on 20", percentage: 20, quantity: 20)
    end

    describe '#all_merch_invoices' do
      it "returns all invoices for a merchant" do
        expect(Invoice.all_merch_invoices(@merch[0])).to eq([@invoice, @invoice1, @invoice8])
      end
    end

    describe "#total discounted revenue" do
      it "can get a total discounted revenue" do
        expect(@invoice.total_discounted_revenue).to eq("30.00")
        expect(@invoice1.total_discounted_revenue).to eq("20.00")
        expect(@invoice2.total_discounted_revenue).to eq("10.00")
        expect(@invoice3.total_discounted_revenue).to eq("40.00")
        expect(@invoice4.total_discounted_revenue).to eq("30.00")
      end
    end
  end
end
