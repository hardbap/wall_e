module WallE
  class Led

    # Public: Initialize an LED
    #
    # pin - the Pin the LED is attached to.
    def initialize(pin)
      @pin = pin
      @is_on = false
    end

    # Public: Turn the LED on.
    #
    # Returns nothing.
    def on
      @pin.set_mode(Pin::OUTPUT)
      @pin.digital_write(Pin::HIGH)
      @is_on = true
    end

    # Public: Turn the LED off.
    #
    # Returns nothing.
    def off
      @pin.set_mode(Pin::OUTPUT)
      @pin.digital_write(Pin::LOW)
      @is_on = false
    end

    # Public: Set the brightness of the LED.
    #
    # Returns nothing.
    def brightness(value)
      @pin.set_mode(Pin::PWM)
      @pin.analog_write(value)
    end

    # Public: Indicates if the LED is currently on.
    #
    # Returns Boolean.
    def on?
      @is_on
    end

    # Public: Indicates if the LED is current off.
    def off?
      !on?
    end

    # Public: Toggle the LED on or off.
    #
    # Returns nothing.
    def toggle
      if on?
        off
      else
        on
      end
    end

    # Public: The current value of the LED.
    #
    # Returns Integer value.
    def value
      @pin.value
    end
  end
end