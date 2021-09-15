require "rails_helper"

RSpec.describe "Admin Invoices Index Page" do
  before :each do
    @joey = Customer.create!(first_name: "Joey", last_name: "Ondricka", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    @cecelia = Customer.create!(first_name: "Cecelia", last_name: "Osinski", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")
    @mariah = Customer.create!(first_name: "Mariah", last_name: "Toy", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")

    @invoice_1 = @joey.invoices.create!(customer_id: 1, status: "cancelled", created_at: "2012-03-25 09:54:09 UTC", updated_at: "2012-03-25 09:54:09 UTC")
    @invoice_2 = @cecelia.invoices.create!(customer_id: 2, status: "completed", created_at: "2012-03-07 12:54:10 UTC", updated_at: "2012-03-13 16:54:10 UTC")
    @invoice_3 = @mariah.invoices.create!(customer_id: 3, status: "in progress", created_at: "2012-03-06 21:54:10 UTC", updated_at: "2012-03-06 21:54:10 UTC")
  end

  describe "Link for each invoice id" do
    it "displays a link of all invoice ids in the system" do
      visit "/admin/invoices"

      expect(page).to have_link("Invoice #{@invoice_1.id}")
      expect(page).to have_link("Invoice #{@invoice_2.id}")
      expect(page).to have_link("Invoice #{@invoice_3.id}")
    end

    it "can direct each id link to the admin invoice show page" do
      visit "/admin/invoices"

      click_on "Invoice #{@invoice_1.id}"

      expect(current_path).to eq("/admin/invoices/#{@invoice_1.id}")
    end

    it "can direct each id link to the admin invoice show page" do
      visit "/admin/invoices"

      click_on @invoice_2.id

      expect(current_path).to eq("/admin/invoices/#{@invoice_2.id}")

      click_on "Invoice #{@invoice_2.id}"

      expect(current_path).to eq("/admin/invoices/#{@invoice_2.id}")
    end
  end

end
