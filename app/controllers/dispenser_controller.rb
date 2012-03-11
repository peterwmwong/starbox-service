require 'dispenser_helper'

class DispenserController < ApplicationController
  @@dispenser = DispenserHelper::Dispenser.new

  respond_to :json
  def create
    result = {}
    bev = Beverage.find_by_id params[:beverage_id]
    respond_with (
      if not bev
        {error: :beverage_not_found}
      elsif dispenser.attempt_dispense
        {ok: true}
      else
        {error: :beverage_already_dispensing}
      end
    )
  end

  respond_to :json
  def show
    respond_with({is_dispensing: dispenser.dispensing?})
  end

  private

  def dispenser
    @@dispenser
  end

end

