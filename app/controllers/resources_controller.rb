class ResourcesController < ApplicationController
  allow_unauthenticated_access only: %i[ index ]

  def index
    @resources = Resource.all
  end

  def show
    @resource = Resource.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
