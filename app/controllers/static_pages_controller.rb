class StaticPagesController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  def index
  	@hi = 'static pages'
  end
end
