module WallE
  class Piezo

    # Public: Initialize a Piezo
    #
    # pin - the Pin the piezo is attached to
    def initialize(pin)
      @pin = pin
      @pin.set_mode(Pin::PWM)
      @is_on = false
    end

    # Public: Turn the piezo on.
    #
    # tone - the Integer tone to play.
    #
    # Returns nothing.
    def on(tone)
      @is_on = true
      @pin.analog_write(tone)
    end

    # Public: Turn the piezo off.
    #
    # Returns nothing.
    def off
      @is_on = false
      @pin.analog_write(0)
    end

    # Public: Indicates if the piezo is currently on.
    #
    # Returns Boolean.
    def on?
      @is_on
    end

    # Pubilc: Indicates if the piezo is currently off.
    #
    # Returns Boolean.
    def off?
      !@is_on
    end
  end
end