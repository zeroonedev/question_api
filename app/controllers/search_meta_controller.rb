class SearchMetaController < ApplicationController

  def index
    categories = Category.all
    writers = Witer.all
  end

end
