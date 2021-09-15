require "rails_helper"

# Admin Invoice Show Page
#
# As an admin,
# When I visit an admin invoice show page
# Then I see information related to that invoice including:
# - Invoice id
# - Invoice status
# - Invoice created_at date in the format "Monday, July 18, 2019"
# - Customer first and last name

RSpec.describe "Admin Invoices Show Page" do
  before :each do
    @joey = Customer.create!(first_name: "Joey", last_name: "Ondricka", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    @cecelia = Customer.create!(first_name: "Cecelia", last_name: "Osinski", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")
    @mariah = Customer.create!(first_name: "Mariah", last_name: "Toy", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")

    @invoice_1 = @joey.invoices.create!(customer_id: 1, status: "in progress", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2012-03-25 09:54:09 UTC")
    @invoice_2 = @joey.invoices.create!(customer_id: 1, status: "in progress", created_at: "2012-03-12 05:54:09 UTC", updated_at: "2012-03-12 05:54:09 UTC")
    # @invoice_3 = @joey.invoices.create!(customer_id: 1, status: "cancelled", created_at: "2012-03-10 00:54:09 UTC", updated_at: "2012-03-25 09:54:09 UTC")
    # @invoice_4 = @joey.invoices.create!(customer_id: 1, status: "completed", created_at: "2012-03-24 15:54:10 UTC", updated_at: "2012-03-24 15:54:10 UTC")
    # @invoice_5 = @joey.invoices.create!(customer_id: 1, status: "completed", created_at: "2012-03-07 19:54:10 UTC", updated_at: "2012-03-07 19:54:10 UTC")
    # @invoice_6 = @joey.invoices.create!(customer_id: 1, status: "cancelled", created_at: "2012-03-09 01:54:10 UTC", updated_at: "2012-03-09 01:54:10 UTC")
    # @invoice_7 = @joey.invoices.create!(customer_id: 1, status: "in progress", created_at: "2012-03-07 21:54:10 UTC", updated_at: "2012-03-07 21:54:10 UTC")
    @invoice_8 = @joey.invoices.create!(customer_id: 1, status: "completed", created_at: "2012-03-13 16:54:10 UTC", updated_at: "2012-03-25 09:54:09 UTC")
    @invoice_9 = @cecelia.invoices.create!(customer_id: 2, status: "cancelled", created_at: "2012-03-07 12:54:10 UTC", updated_at: "2012-03-13 16:54:10 UTC")
    @invoice_10 = @mariah.invoices.create!(customer_id: 3, status: "completed", created_at: "2012-03-06 21:54:10 UTC", updated_at: "2012-03-06 21:54:10 UTC")

    @zara = Merchant.create!(name: "Zara")
    @forever_21 = Merchant.create!(name: "Forever 21")

    @hat = @zara.items.create!(name: "Hat", description: "Sun hat", unit_price: 1200, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @socks = @zara.items.create!(name: "Socks", description: "Heart pattern socks", unit_price: 600, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @tank_top = @zara.items.create!(name: "Tank top", description: "Work out tank top", unit_price: 1800, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @shorts = @forever_21.items.create!(name: "Shorts", description: "Black denim shorts", unit_price: 4000, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @dress = @forever_21.items.create!(name: "Dress", description: "Sun dress", unit_price: 2900, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @skirt = @forever_21.items.create!(name: "Skirt", description: "Polka dot skirt", unit_price: 2500, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")

    @invoice_item_1 = InvoiceItem.create!(item: @hat, invoice: @invoice_1, quantity: 2, unit_price: 2400, status: "pending", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @invoice_item_2 = InvoiceItem.create!(item: @socks, invoice: @invoice_1 , quantity: 2, unit_price: 1200, status: "pending", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    # InvoiceItem.create!(item: , invoice: , quantity:  , unit_price:  , status:   )
    # InvoiceItem.create!(item: , invoice: , quantity:  , unit_price:  , status:   )
    # InvoiceItem.create!(item: , invoice: , quantity:  , unit_price:  , status:   )
    # InvoiceItem.create!(item: , invoice: , quantity:  , unit_price:  , status:   )
    # InvoiceItem.create!(item: , invoice: , quantity:  , unit_price:  , status:   )
    # InvoiceItem.create!(item: , invoice: , quantity:  , unit_price:  , status:   )
    # InvoiceItem.create!(item: , invoice: , quantity:  , unit_price:  , status:   )
  end

#   Admin Invoice Show Page: Invoice Item Information
#
# As an admin
# When I visit an admin invoice show page
# Then I see all of the items on the invoice including:
# - Item name
# - The quantity of the item ordered
# - The price the Item sold for
# - The Invoice Item status

  describe "Invoice Info" do
    it "display that invoice's information" do
      visit "/admin/invoices/#{@invoice_1.id}"

      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_1.status)
      expect(page).to have_content(@invoice_1.created_at.strftime("%A, %B %d, %Y"))
      expect(page).to have_content(@invoice_1.updated_at.strftime("%A, %B %d, %Y"))
      expect(page).to have_content(@invoice_1.customer.first_name)
      expect(page).to have_content(@invoice_1.customer.last_name)
    end
  end

  describe "Items on Invoice" do
    it "displays the items' info on that invoice" do
      visit "/admin/invoices/#{@invoice_1.id}"

      expect(page).to have_content(@hat.name)
      expect(page).to have_content(@invoice_item_1.quantity)
      expect(page).to have_content(@invoice_item_1.unit_price)
      expect(page).to have_content(@invoice_item_1.status)
    end
  end

end
