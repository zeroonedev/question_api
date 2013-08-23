
class FormMetadatumController < ApplicationController
  before_filter :authenticate_user!

  def index
    @meta = FormMetadataFactory.build
    render :json => @meta
  end

end
