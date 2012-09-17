require 'forwardable'

module WallE
  class Claw
    extend Forwardable

    def_delegators :@pan_servo, :min, :max, :center

    # Public: Initialize a Claw
    #
    # claw_servo - the Servo controlling the claw.
    # pan_servo  - the Servo controlling the pan/tilt bracket.
    def initialize(claw_servo, pan_servo)
      @claw_servo = claw_servo
      @pan_servo = pan_servo
    end

    # Public: open the claw.
    #
    # Returns nothing.
    def let_go
      @claw_servo.min
    end

    # Public: close the claw.
    #
    # Returns nothing.
    def grab
      @claw_servo.max
    end

    # Public: close the claw.
    #
    # degrees - the Integer degrees to move the claw to.
    #
    # Returns nothing.
    def pinch(degrees)
      @claw_servo.move_to degrees
    end

    # Public: tilt the claw.
    #
    # degrees - the Integer degrees to tilt the claw.
    #
    # Returns nothing.
    def tilt(degrees)
      @pan_servo.move_to degrees
    end

    # Public: Indicates if the claw currently open.
    #
    # Returns truthy/falsy value.
    def open?
      !closed?
    end

    # Public: Indicates if the claw is currently closed.
    #
    # Returns truthy/falsy value.
    def closed?
      @claw_servo.maxed?
    end
  end
end