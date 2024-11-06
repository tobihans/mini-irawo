class ResourcesController < ApplicationController
  allow_unauthenticated_access only: %i[ index show ]

  def index
    @resources = Resource.order(created_at: :desc).by_category(params[:category_id]).by_pricing(params[:pricing])
  end

  def show
    @resource = Resource.find(params[:id])
  end

  def new
    @resource = Resource.new
  end

  def create
    @resource = Resource.new(resource_params)

    if @resource.save
      redirect_to @resource
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @resource = Resource.find(params[:id])
  end

  def update
    @resource = Resource.find(params[:id])

    if @resource.update(resource_params)
      redirect_to @resource
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def resource_params
    params.require(:resource).permit(:name, :image, :category_id, :kind, :price, :url, :file, :description)
  end
end
