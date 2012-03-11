module DispenserHelper
  DISPENSE_BEVERAGE_DELAY_SECONDS = 2.seconds

  class Dispenser
    
    def initialize
      @dispense_lock = Mutex.new
      @last_dispense = nil
    end

    def dispensing?
      @dispense_lock.synchronize { _is_dispensing }
    end

    def attempt_dispense
      @dispense_lock.synchronize do
        unless _is_dispensing
          self.last_dispense = Time.now + DISPENSE_BEVERAGE_DELAY_SECONDS
          true
        else
          false
        end
      end
    end

    private

    def last_dispense
      @last_dispense
    end

    def last_dispense=(d)
      @last_dispense = d
    end

    def _is_dispensing
      last_dispense != nil && Time.now < last_dispense
    end

  end

end
