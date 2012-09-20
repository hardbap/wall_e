module WallE
  class Button

    # Public: Initialize a Button.
    #
    # pin       - the Pin the Button is attached to.
    # hold_time - the Integer seconds to indicate that the button is being held (default: 0.07).
    def initialize(pin, hold_time = 0.7)
      @pin = pin
      @pin.set_mode(Pin::INPUT)
      @pin.start_reporting
      @hold_time = hold_time
      @pin.on("digital-read-#{@pin.number}", method(:handler))
    end

    # Public: What to do when the button is pressed.
    #
    # block - the block that will run when the button is pressed.
    #
    # Returns nothing.
    def pressed(&block)
      @down_callback = block
    end

    # Public: What to do when the button is released.
    #
    # block - the block that will run when the button is released.
    #
    # Returns nothing.
    def released(&block)
      @up_callback = block
    end

    # Public: What to do when the button is held.
    #
    # block - the block that will be run when the button is held.
    #
    # Returns nothing.
    def held(&block)
      @hold_callback = block
    end

    # Internal: The handler for the Pin's read event.
    #
    # value - the Integer returned from the read event.
    #
    # Returns nothing.
    def handler(value)
      if value.zero?
        @up_callback.call if @up_callback
      else
        @last_press = Time.now
        @down_callback.call if @down_callback
      end

      if value.zero? && (Time.now - @last_press) > @hold_time
        @hold_callback.call if @hold_callback
      end
    end
  end
end