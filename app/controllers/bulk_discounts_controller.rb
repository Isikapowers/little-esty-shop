class BulkDiscountsController < ApplicationController
  def index
    @bulk_discounts = Merchant.find(params[:merchant_id]).bulk_discounts
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.new(discount_params)
    if @bulk_discount.save
      flash[:success] = 'Bulk Discount added successfully!'
      redirect_to merchant_bulk_discounts_path(@merchant)
    else
      flash[:danger] = 'Bulk Discount Not Created: Please re-enter information.'
      redirect_to new_merchant_bulk_discount_path(@merchant)
    end
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
    @bulk_discount.destroy
    flash[:success] = 'Bulk Discount Deleted!'
    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  private

  def discount_params
    params.require(:bulk_discount).permit(:percent_discount, :threshold)
  end
end
