class Admin::OrdersController < ApplicationController
  before_action :authorize
  def filter
    if params[:status] == "all"
      @orders = Order.all.paginate(page: params[:page])
    else
      @orders = Order.where("status = ?", params[:status]).paginate(page: params[:page])
    end
    redirect_to admin_path(status: params[:status])
  end

  def update
    order = Order.find(params[:id])
    order.update_attributes(status: params[:new_status])
    redirect_to admin_path
  end
end
