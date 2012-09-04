module WallE
  class Led

    attr_reader :pin_number, :pin, :board

    def initialize(pin_number, board)
      @pin_number = pin_number
      @board = board
      @pin = @board.pins[@pin_number]
      @is_on = false
      @is_running = false
    end

    def on
      board.set_pin_to_output(@pin_number)
      board.digital_write @pin_number, 1
      @is_on = true
    end

    def off
      board.set_pin_to_output(@pin_number)
      board.digital_write @pin_number, 0
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
      @is_running?
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