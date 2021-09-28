class InvoiceItemController < ApplicationController
  def update
    @inv_item = InvoiceItem.find(params[:id])
    @inv_item.update(status: params[:invoice_item][:status])

    redirect_to merchant_invoice_path(params[:merchant_id], params[:invoice_item][:invoice_id])

    flash[:success] = "Item Updated Successfully"
  end
end
