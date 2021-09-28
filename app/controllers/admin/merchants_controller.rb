  class Admin::MerchantsController < ApplicationController
    def index
      @merchants = Merchant.all
    end

    def show
      @merchant = Merchant.find(params[:id])
    end

    def edit
      @merchant = Merchant.find(params[:id])
    end

    def update
      @merchant = Merchant.find(params[:id])
      if params[:enable] == 'true'
        @merchant.update(status: params[:status])
        redirect_to "/admin/merchants"
      elsif @merchant.update(merch_params)
        redirect_to "/admin/merchants/#{@merchant.id}"
        flash[:success] = 'Merchant Updated successfully'
      else
        redirect_to "/admin/merchants/#{@merchant.id}/edit"
        flash[:danger] = 'Merchant Not Updated: Re-enter information'
      end
    end

    def new
      @merchant = Merchant.new
    end

    def create
      @merchant = Merchant.new(merch_params)
      if @merchant.save
        flash[:success] = 'Merchant Updated successfully'
        redirect_to '/admin/merchants'
      else
        redirect_to admin_merchants_url
        flash[:danger] = 'Merchant Not Created: Re-enter information'
      end
    end

    private

    def merch_params
       params.require(:merchant).permit(:name, :status)
    end
  end
