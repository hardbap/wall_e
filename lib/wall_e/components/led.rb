module WallE
  class Led

    attr_reader :pin

    def initialize(pin)
      @pin = pin
      @is_on = false
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
    end

    def brightness(value)
      @pin.set_mode(Pin::PWM)
      @pin.analog_write(value)
    end

    def on?
      @is_on
    end

    def off?
      !on?
    end

    def toggle
      if on?
        off
      else
        on
      end
    end

    def value
      @pin.value
    end

    def mode
      @pin.mode
    end
  end
end