class OrdersController < ApplicationController
  allow_unauthenticated_access only: %i[ show create ]

  def index
    @orders = Order.joins(:resource)
      .where(user: Current.user)
      .order(created_at: :desc)
      .paginate(page: pagination_params[:page], per_page: 20)
  end

  def show
    @order = staff? ? Order.find(params[:id]) : Order.where(user: Current.user).find(params[:id])

    if params[:get]
      case @order.resource.kind
      when Resource::VALID_KINDS.first
        redirect_to @order.resource.url, allow_other_host: true
      when Resource::VALID_KINDS.last
        redirect_to rails_blob_path(@order.resource.file, disposition: :attachment)
      end
    end
  end

  def create
    if staff?
      flash[:notice] = t("errors.admin_cannot_buy")
    end
    resource = Resource.find(order_params[:resource_id])
    @order = Order.new(resource: resource, user: Current.user)

    if @order.save
      flash[:notice] = t("orders.create.success")
      unless Current.user
        flash[:alert] = t("orders.create.guest_warn")
      end
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

  def pagination_params
    params.permit(:page)
  end
end
