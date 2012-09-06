require_relative 'pin'
require 'wall_e/components/led'

module WallE
  class Board
    extend Forwardable

    attr_reader :firmata

    def_delegators :@firmata, :digital_write, :digital_read, :analog_write, :set_pin_mode, :pins, :delay

    def initialize(firmata)
      @firmata = firmata
      @firmata.connect unless firmata.connected?
    end

    def Led(pin_number)
      pin = Pin.new(pin_number, self)
      Led.new(pin)
    end
  end
end