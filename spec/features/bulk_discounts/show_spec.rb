require 'rails_helper'

describe 'BulkDiscount Show Page' do
  before :each do
    @merch = create(:merchant)
    @discount = @merch.bulk_discounts.create!(percent_discount: 10, threshold: 5)
  end

  describe 'attributes' do
    it 'can show threshold and opercent discount' do
      visit merchant_bulk_discount_path(@merch, @discount)

      expect(page).to have_content(@discount.threshold)
      expect(page).to have_content(@discount.percent_discount)
    end
  end
end
