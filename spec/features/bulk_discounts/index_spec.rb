require 'rails_helper'

RSpec.describe 'Merchant BulkDiscount Index' do
  before :each do
    @merch = create(:merchant)
    @m1_discount = @merch.bulk_discounts.create!(percent_discount: 10, threshold: 5)
    @m1_discount2 = @merch.bulk_discounts.create!(percent_discount: 15, threshold: 11)
  end

  describe 'as a Merchant' do
    it 'shows all BulkDiscounts by Merchant' do
      visit merchant_bulk_discounts_path(@merch)

      @merch.bulk_discounts.each do |discount|
        expect(page).to have_content(discount.percent_discount)
        expect(page).to have_content(discount.threshold)
      end
    end

    it 'all BulkDiscounts have a link to it\'s show page' do
      visit merchant_bulk_discounts_path(@merch)

      click_link("Bulk Discount Threshold: #{@m1_discount.threshold} Bulk Discount Percentage: #{@m1_discount.percent_discount}")
      expect(current_path).to eq(merchant_bulk_discount_path(@merch, @m1_discount))
    end
  end

  describe 'create a Discount' do
    it 'can create discount' do
      visit merchant_bulk_discounts_path(@merch)
      click_on('Create Discount')

      expect(current_path).to eq(new_merchant_bulk_discount_path(@merch))

      fill_in('Percent discount', with: 20)
      fill_in('Threshold', with: 20)
      click_button('Create Discount')

      @new_m1_discount = @merch.bulk_discounts.last

      expect(current_path).to eq(merchant_bulk_discounts_path(@merch))
      expect(page).to have_content(@new_m1_discount.percent_discount)
      expect(page).to have_content(@new_m1_discount.threshold)
      expect(page).to have_content('Bulk Discount added successfully!')
    end

    it 'returns flash message and reloads page w/sad path' do
      visit new_merchant_bulk_discount_path(@merch)

      fill_in('Percent discount', with: '')
      fill_in('Threshold', with: '')
      click_on('Create Discount')

      @new_m1_discount = @merch.bulk_discounts.last

      expect(current_path).to eq(new_merchant_bulk_discount_path(@merch))
      expect(page).not_to have_content(@new_m1_discount.percent_discount)
      expect(page).not_to have_content(@new_m1_discount.threshold)
      expect(page).to have_content('Bulk Discount Not Created: Please re-enter information.')
    end
  end

  describe 'BulkDiscount Delete' do
    it 'will delete BulkDiscount' do
      visit merchant_bulk_discounts_path(@merch)

      @merch.bulk_discounts.each do |discount|
        expect(page).to have_link("Delete Discount ID #{discount.id}")
      end

      click_link("Delete Discount ID #{@m1_discount2.id}")

      expect(current_path).to eq(merchant_bulk_discounts_path(@merch))
      expect(page).to have_content('Bulk Discount Deleted!')
      expect(page).not_to have_content(@m1_discount2.percent_discount)
      expect(page).not_to have_content(@m1_discount2.threshold)
    end
  end
end
