module WallE
  class Servo
    OutOfBoundsError = Class.new(StandardError)

    # Public: Initialize a Servo
    #
    # pin     - the Pin the servo is attached to.
    # options - the Hash options to configure the servo (default: {}):
    #           :range - the Range to restrict movement (default 0..180).
    def initialize(pin, options = {})
      @pin = pin
      @pin.set_mode(Pin::SERVO)
      @range = options.fetch(:range) { 0..180 }
    end

    # Public: Move the servo the the minimum degree.
    #
    # Returns nothing.
    def min
      move_to @range.min
    end

    # Public: Move the servo to the maximum degree.
    #
    # Returns nothing.
    def max
      move_to @range.max
    end

    # Public: Move the servo to the center degree.
    #
    # Returns nothing.
    def center
      move_to ((min + max) / 2).abs
    end

    # Public: Move the servo.
    #
    # degrees - the Integer degrees to move to.
    #
    # Returns nothing.
    # Raises OutOfBoundsError if the servo cannot move to the degree.
    def move_to(degrees)
      raise OutOfBoundsError unless @range.include?(degrees)
      @pin.servo_write(degrees)
    end

    def maxed?
      position == @range.max
    end

    def position
      @pin.value
    end
  end
end