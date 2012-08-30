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
      set_pin_to_output
      board.digital_write @pin_number, 1
      @is_on = true

      self
    end

    def on?
      @is_on
    end

    def off
      set_pin_to_output
      board.digital_write @pin_number, 0
      @is_on = false
      @is_running = false

      self
    end

    def toggle

      self
    end

    def strobe

      self
    end

    def brightness

      self
    end

    def fade

      self
    end

    def set_pin_to_output
      mode = 0x01

      if @pin.supported_modes.include?(mode)
        board.set_pin_mode(@pin_number, mode)
      else
        # what to do?
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