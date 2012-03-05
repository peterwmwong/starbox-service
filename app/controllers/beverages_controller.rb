class BeveragesController < ApplicationController
  
  respond_to :json
  def index
    respond_with Beverage.all_for_json
  end

  respond_to :json
  def show
    bev = Beverage.find_by_id params[:id]
    respond_with bev || {}
  end

end
