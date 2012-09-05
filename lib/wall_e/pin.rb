module WallE
  class Pin
    class UnsupportedModeError < StandardError; end

    # Internal: Fixnum byte for pin mode input.
    INPUT = 0x00
    # Internal: Fixnum byte for pin mode output.
    OUTPUT = 0x01
    # Internal: Fixnum byte for pin mode analog.
    ANALOG = 0x02
    # Internal: Fixnum byte for pin mode pulse width modulation.
    PWM = 0x03
    # Internal: Fixnum byte for pin mode servo.
    SERVO = 0x04

    attr_reader :number, :board

    def initialize(number, board, mode = OUTPUT)
      @number = number
      @board = board
      @onboard_pin = @board.pins[@number]
      set_mode(mode)
    end

    def digital_write(value)
      @board.digital_write(@number, value)
    end

    def set_mode(mode)
      raise UnsupportedModeError unless @onboard_pin.supported_modes.include?(mode)
      @board.set_pin_mode(@number, mode)
    end

    def current_mode
      @onboard_pin.mode
    end

    def value
      @onboard_pin.value
    end
  end
end