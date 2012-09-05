module WallE
  class Led

    attr_reader :pin

    def initialize(pin)
      @pin = pin
      @pin.set_mode(Pin::OUTPUT)
      @is_on = false
      @is_running = false
    end

    def on
      pin.digital_write(1)
      @is_on = true
    end

    def off
      pin.digital_write(0)
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
    end

    def strobe
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