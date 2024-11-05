class ResourcesController < ApplicationController
  allow_unauthenticated_access only: %i[ index show ]

  def index
    @resources = Resource.all
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
      # redirect_to @resource
      # TODO: Redirect to admin view of resource
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def resource_params
    params.require(:resource).permit(:name, :image, :category_id, :kind, :url, :file, :description)
  end
end
