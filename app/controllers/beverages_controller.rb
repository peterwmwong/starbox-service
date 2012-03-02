class BeveragesController < ApplicationController
  respond_to :json
  def show
    respond_with Beverage.all_for_json
  end
end
