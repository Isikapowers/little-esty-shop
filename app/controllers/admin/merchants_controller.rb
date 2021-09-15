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
      merchant = Merchant.find(params[:id])
      if merchant.update(merch_params)
       redirect_to "/admin/merchants/#{merchant.id}"
       flash[:success] = 'Merchant Updated'
      else
       redirect_to "/admin/merchants/#{merchant.id}/edit"
       flash[:danger] = 'Merchant Not Updated: re-enter information'
      end
    end

    def create
    end

    private

    def merch_params
      params.permit(:name)
    end
  end
