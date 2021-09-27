require 'rails_helper'

describe BulkDiscount, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:items).through :merchant }
  end

  describe 'validations' do
    it { should validate_presence_of(:percent_discount) }
    it { should validate_presence_of(:threshold) }
  end
end
