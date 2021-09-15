require 'rails_helper'

RSpec.describe "Merchant Dashboard" do
  before :each do
    @merch = Merchant.create!({name: "Douglas Olson"})
    @item1 = @merch.items.create!(name: "Polly Pocket", description: "So pretty", unit_price: 862, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @item2 = @merch.items.create!(name: "Cabbage Patch Doll", description: "Cute", unit_price: 1239, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @item3 = @merch.items.create!(name: "Teddy Ruxpin", description: "Creepy", unit_price: 1543, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @item4 = @merch.items.create!(name: "Barbie", description: "Gorgeous", unit_price: 2183, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @item5 = @merch.items.create!(name: "GI Joe", description: "Imperialism", unit_price: 743, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @cust1 = build(:customer)

  end

  it "displays the name of the merchant" do
    visit "/merchant/#{@merch.id}/dashboard"

    expect(page).to have_content(@merch.name)
  end

  it "displays links to merchant items and invoices indexes" do
    visit "/merchant/#{@merch.id}/dashboard"

    expect(page).to have_link("My Items")
    click_link "My Items"
    expect(current_path).to eq("/merchant/#{@merch.id}/items")

    visit "/merchant/#{@merch.id}/dashboard"

    expect(page).to have_link("My Invoices")
    click_link "My Invoices"
    expect(current_path).to eq("/merchant/#{@merch.id}/invoices")
  end

  it "displays items ready to ship and their invoice ids" do

  end

  it "gives invoice ids as links to invoice show pages" do

  end
end
