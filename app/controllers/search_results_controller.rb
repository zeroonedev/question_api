class SearchResultsController < ApplicationController

	def index
		
	end

	
	def show
		pdf = Prawn::Document.new
		pdf.text "Hello World"
		pdf.render_file "assignment.pdf"
	end
end
