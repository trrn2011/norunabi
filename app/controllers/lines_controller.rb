class LinesController < ApplicationController
  before_action :require_login
  def show
    @line = Line.find(params[:id])
  end
  
  def index
    @lines = Line.all
  end
  
  
  
  
  
end
