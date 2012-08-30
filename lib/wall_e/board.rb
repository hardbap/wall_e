require 'wall_e/serial_snoop'
require 'wall_e/components/led'

module WallE
  class Board
    extend Forwardable

    attr_reader :firmata

    def_delegators :@firmata, :digital_write, :digital_read, :set_pin_mode, :pins

    def initialize
      @firmata = SerialSnoop.locate_ports
      @firmata.connect
    end

    def add_led(pin)
      Led.new(pin, self)
    end
  end
end