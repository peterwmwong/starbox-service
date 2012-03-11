require 'spec_helper'

class MockDispenser
  def initialize(opts = {})
    @dispensing = (opts[:dispensing] == true)
    @attempt_dispense = (opts[:attempt_dispense] == true)
  end

  def attempt_dispense
    @attempt_dispense
  end

  def dispensing?
    @dispensing
  end

end

describe DispenserController do

  describe "renders create" do
    before do
      @bev = Beverage.create( name: 'Cafe Americano' )
    end

    it "when bogus beverage id, error" do
      get :create, {format: :json, beverage_id: 777}
      response.should be_success
      response.body.should == {
        error: :beverage_not_found
      }.to_json
    end

    it "when NOT dispensing, ok" do
      controller.stub dispenser: MockDispenser.new(attempt_dispense: true)
      get :create, {format: :json, beverage_id: @bev.id}
      response.should be_success
      response.body.should == {
        ok: true
      }.to_json
    end

    it "when dispensing, error already dispensing" do
      controller.stub dispenser: MockDispenser.new(attempt_dispense: false)
      get :create, {format: :json, beverage_id: @bev.id}
      response.should be_success
      response.body.should == {
        error: :beverage_already_dispensing
      }.to_json
    end

  end

  describe 'renders show' do

    it 'when NOT dispensing' do
      controller.stub dispenser: MockDispenser.new(dispensing: false)
      get :show, :format => :json
      response.should be_success
      response.body.should == {
        is_dispensing: false
      }.to_json
    end

    it 'when dispensing' do
      controller.stub dispenser: MockDispenser.new(dispensing: true)
      get :show, :format => :json
      response.should be_success
      response.body.should == {
        is_dispensing: true
      }.to_json
    end

  end

end
