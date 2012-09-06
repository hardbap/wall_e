module WallE
  class Led

    attr_reader :pin

    def initialize(pin)
      @pin = pin
      @is_on = false
      @is_running = false
    end

    def on
      @pin.set_mode(Pin::OUTPUT)
      @pin.digital_write(Pin::HIGH)
      @is_on = true
    end

    def off
      @pin.set_mode(Pin::OUTPUT)
      @pin.digital_write(Pin::LOW)
      @is_on = false
      @is_running = false
    end

    def on?
      @is_on
    end

    def off?
      !on?
    end

    def running?
      @is_running
    end

    def toggle
      if on? or running?
        off
      else
        on
      end
    end

    def blink(rate = 0.1)
      @is_running = true

      ->() { toggle; pin.delay(0.1) }
    end

    def brightness
    end

    def fade
    end

    def value
      @pin.value
    end

    def mode
      @pin.mode
    end
  end
end