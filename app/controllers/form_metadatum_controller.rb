
class FormMetadatumController < ApplicationController

  def index
    @meta = FormMetadataFactory.build
    render :json => @meta
  end

end