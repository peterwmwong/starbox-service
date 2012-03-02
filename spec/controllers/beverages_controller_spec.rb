require 'spec_helper'

describe BeveragesController do
  describe 'GET index JSON' do
    before do
      get :index, :format => :json
      @beverages = JSON.parse response.body
    end
  end
end
