require "rails_helper"

RSpec.describe "Bulk Discounts Show Page" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')
    @merchant3 = Merchant.create!(name: 'Office Space')

    @discount1 = @merchant1.bulk_discounts.create!(name: "10% off on 10", percentage: 10, quantity: 10)
    @discount2 = @merchant1.bulk_discounts.create!(name: "20% off on 20", percentage: 20, quantity: 20)
    @discount3 = @merchant1.bulk_discounts.create!(name: "30% off on 30", percentage: 30, quantity: 30)
  end

  describe "discount's atrributes" do
    it "displays that discount's attributes" do
      visit merchant_bulk_discount_path(@merchant1, @discount1)

      expect(page).to have_content(@discount1.name)
      expect(page).to have_content(@discount1.percentage)
      expect(page).to have_content(@discount1.quantity)
    end

    it "displays that discount's attributes" do
      visit merchant_bulk_discount_path(@merchant1, @discount2)

      expect(page).to have_content(@discount2.name)
      expect(page).to have_content(@discount2.percentage)
      expect(page).to have_content(@discount2.quantity)
    end
  end

  describe "edit a discount" do
    it "allows the merchant to edit their discounts" do
      visit merchant_bulk_discount_path(@merchant1, @discount1)

      expect(page).to have_link("Edit Discount")
    end

    it "redirects the merchant to the form that is pre-populated" do
      visit merchant_bulk_discount_path(@merchant1, @discount1)

      click_on "Edit Discount"

      expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant1, @discount1))
      expect(page).to have_field("Discount Name")
      expect(page).to have_field("Percentage")
      expect(page).to have_field("Minimum Quantity")
    end

    it "allows the merchant to edit and update" do
      visit edit_merchant_bulk_discount_path(@merchant1, @discount1)

      fill_in "Discount Name", with: "Columbus Day Sale"
      fill_in "Percentage", with: "15"
      fill_in "Minimum Quantity", with: "10"

      click_on "Update Discount"

      expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @discount1))
    end
  end
end
