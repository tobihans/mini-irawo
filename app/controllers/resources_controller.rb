class ResourcesController < ApplicationController
  allow_unauthenticated_access only: %i[ index ]

  def index
    @resources = Resource.all
  end
end
