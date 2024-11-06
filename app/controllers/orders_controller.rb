class OrdersController < ApplicationController
  allow_unauthenticated_access only: %i[ show create ]

  def new
    @order = Order.new(resource: Resource.first)
  end

  def index
  end

  def show
  end

  def create
    resource = Resource.find(order_params[:resource_id])
    @order = Order.new(resource: resource, user: Current.user)

    if @order.save
      flash[:notice] = t("orders.create.success")
      redirect_to @order
    else
      flash[:alert] = t("orders.create.error")
      redirect_to resource
    end
  end

  private

  def order_params
    params.require(:order).permit(:resource_id)
  end
end
