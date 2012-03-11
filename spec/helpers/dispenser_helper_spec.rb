require 'spec_helper'
require 'dispenser_helper'

describe DispenserHelper do

  describe 'Dispenser' do

    before do
      @dispenser = DispenserHelper::Dispenser.new
    end

    describe "#attempt_dispense" do

      it "when dispensing" do
        exp_last_dispense = Time.now + DispenserHelper::DISPENSE_BEVERAGE_DELAY_SECONDS
        @dispenser.stub :_is_dispensing => true
        @dispenser.should_not_receive :last_dispense=
        @dispenser.attempt_dispense.should == false
      end

      it "when NOT dispensing" do
        exp_last_dispense = Time.now + DispenserHelper::DISPENSE_BEVERAGE_DELAY_SECONDS
        @dispenser.stub :_is_dispensing => false
        @dispenser.should_receive :last_dispense= do |arg|
          arg.tv_sec.should == exp_last_dispense.tv_sec
        end
        @dispenser.attempt_dispense.should == true
      end

    end

    describe "#dispensing?" do

      it "when last_dispense is nil" do
        @dispenser.stub :last_dispense => nil
        @dispenser.dispensing?.should == false
      end
      it "when last_dispense is within DISPENSE_BEVERAGE_DELAY_SECONDS" do
        @dispenser.stub :last_dispense => Time.now + DispenserHelper::DISPENSE_BEVERAGE_DELAY_SECONDS
        @dispenser.dispensing?.should == true
      end

      it "when last_dispense is outside of DISPENSE_BEVERAGE_DELAY_SECONDS" do
        @dispenser.stub :last_dispense => Time.now + DispenserHelper::DISPENSE_BEVERAGE_DELAY_SECONDS + 1.seconds
        @dispenser.dispensing?.should == true
      end

    end
  end
end
