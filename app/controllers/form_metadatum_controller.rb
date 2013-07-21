
class FormMetadatumController < ApplicationController
  before_filter :authenticate_user!

  filter_resource_access

  def index
    @meta = FormMetadataFactory.build
    render :json => @meta
  end

end