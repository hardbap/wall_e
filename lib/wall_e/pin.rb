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

    LOW  = 0
    HIGH = 1

    # Public: Returns the Integer pin number.
    attr_reader :number

    # Public: Initialize a Pin
    #
    # number - the Integer pin number on the board.
    # board  - the WallE::Board this pin is on.
    # mode   - the Fixnum mode to set the pin to (default: OUTPUT).
    def initialize(number, board, mode = OUTPUT)
      @number = number
      @board = board
      @onboard_pin = @board.pins[@number]
      set_mode(mode)
    end

    # Public: Write a digital value to the pin.
    #
    # value - an Integer value.
    #
    # Returns nothing.
    def digital_write(value)
      @board.digital_write(@number, value)
    end

    def delay(seconds)
      @board.delay(seconds)
    end

    # Public: Set the pin mode.
    #
    # mode - an Integer mode.
    #
    # Returns nothing.
    # Raises UnsupportedModeError if the pin does not support the mode.
    def set_mode(mode)
      raise UnsupportedModeError unless @onboard_pin.supported_modes.include?(mode)

      @board.set_pin_mode(@number, mode) unless current_mode == mode
    end

    # Public: Get the current mode.
    #
    # Returns Integer mode.
    def current_mode
      @onboard_pin.mode
    end

    def in_output?
      current_mode == OUTPUT
    end

    # Public: Get the current value of the pin.
    #
    # Returns Integer value.
    def value
      @onboard_pin.value
    end
  end
end