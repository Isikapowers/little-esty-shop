require "rails_helper"

RSpec.describe "Bulk Discount Index Page" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')
    @merchant3 = Merchant.create!(name: 'Office Space')

    @discount1 = @merchant1.bulk_discounts.create!(name: "10% off on 10", percentage: 10, quantity: 10)
    @discount2 = @merchant1.bulk_discounts.create!(name: "20% off on 20", percentage: 20, quantity: 20)
    @discount3 = @merchant1.bulk_discounts.create!(name: "30% off on 30", percentage: 30, quantity: 30)
  end

  describe "merchant's bulk discounts" do
    it "displays a link to view all that merchant's discount" do
      visit "/merchant/#{@merchant1.id}/dashboard"

      expect(page).to have_link("All My Discounts")
    end

    it "can take that merchant to their bulk discount index page" do
      visit "/merchant/#{@merchant1.id}/dashboard"

      click_on "All My Discounts"

      expect(current_path).to eq("/merchant/#{@merchant1.id}/bulk_discounts")

      within("#discount-#{@discount1.id}") do
        expect(page).to have_link(@discount1.name)
        expect(page).to have_content(@discount1.percentage)
        expect(page).to have_content(@discount1.quantity)
      end

      within("#discount-#{@discount2.id}") do
        expect(page).to have_link(@discount2.name)
        expect(page).to have_content(@discount2.percentage)
        expect(page).to have_content(@discount2.quantity)
      end

      within("#discount-#{@discount3.id}") do
        expect(page).to have_link(@discount3.name)
        expect(page).to have_content(@discount3.percentage)
        expect(page).to have_content(@discount3.quantity)
      end
    end

    it "can take that merchant to their discount show page" do
      visit "/merchant/#{@merchant1.id}/bulk_discounts"

      click_on @discount1.name

      expect(current_path).to eq("/merchant/#{@merchant1.id}/bulk_discounts/#{@discount1.id}")
    end
  end

  describe "upcoming holidays" do
    it 'displays a "Upcoming Holidays" header' do
      visit merchant_bulk_discounts_path(@merchant1)

      expect(page).to have_content("Upcoming Holidays")
    end

    it "displays the name/date of the next 3 upcoming US holidays" do
      visit merchant_bulk_discounts_path(@merchant1)

      expect(page).to have_content(NagerDateService.next_three_holidays.first.name)
      expect(page).to have_content(NagerDateService.next_three_holidays.second.name)
      expect(page).to have_content(NagerDateService.next_three_holidays.third.name)
    end
  end

  describe "creating a new discount" do
    it "displays a link to create a new discount" do
      visit merchant_bulk_discounts_path(@merchant1)

      expect(page).to have_link("Create New Discount")

      click_on "Create New Discount"

      expect(current_path).to eq("/merchant/#{@merchant1.id}/bulk_discounts/new")
    end

    it "can redirect the merchant back to bulk discount index page after creating a discount" do
      visit "/merchant/#{@merchant1.id}/bulk_discounts/new"

      fill_in "Discount Name", with: "Christmas 30% Off"
      fill_in "Percentage", with: "30"
      fill_in "Minimum Quantity", with: "10"

      click_on "Create Discount"

      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
      expect(page).to have_content("Discount has been successfully created!")
    end

    it "displays an error message when not all fields have been filled in" do
      visit "/merchant/#{@merchant1.id}/bulk_discounts/new"

      fill_in "Discount Name", with: ""
      fill_in "Percentage", with: "30"
      fill_in "Minimum Quantity", with: "10"

      click_on "Create Discount"

      expect(current_path).to eq("/merchant/#{@merchant1.id}/bulk_discounts/new")
      expect(page).to have_content("Error: Please fill in all the fields")
    end
  end
end
# Merchant Bulk Discount Create
#
# As a merchant
# When I visit my bulk discounts index
# Then I see a link to create a new discount
# When I click this link
# Then I am taken to a new page where I see a form to add a new bulk discount
# When I fill in the form with valid data
# Then I am redirected back to the bulk discount index
# And I see my new bulk discount listed


# As a merchant
# When I visit the discounts index page
# I see a section with a header of "Upcoming Holidays"
# In this section the name and date of the next 3 upcoming US holidays are listed.
#
# Use the Next Public Holidays Endpoint in the [Nager.Date API](https://date.nager.at/swagger/index.html)

# Merchant Bulk Discounts Index
#
# As a merchant
# When I visit my merchant dashboard
# Then I see a link to view all my discounts
# When I click this link
# Then I am taken to my bulk discounts index page
# Where I see all of my bulk discounts including their
# percentage discount and quantity thresholds
# And each bulk discount listed includes a link to its show page
