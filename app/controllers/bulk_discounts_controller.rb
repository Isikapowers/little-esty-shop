class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = BulkDiscount.all
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.new
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = merchant.bulk_discounts.new(discount_params)
    if bulk_discount.save
      redirect_to merchant_bulk_discounts_path(merchant)
      flash[:success] = "Discount has been successfully created!"
    else
      redirect_to new_merchant_bulk_discount_path(merchant)
      flash[:alert] = "Error: Please fill in all the fields"
    end
  end


  private

  def discount_params
    params.require(:bulk_discount).permit(:name, :percentage, :quantity)
  end
end
