
require 'wall_e/components/led'

module WallE
  class Board
    extend Forwardable

    attr_reader :firmata

    def_delegators :@firmata, :digital_write, :digital_read, :set_pin_mode, :pins

    def initialize(firmata)
      @firmata = firmata
      @firmata.connect unless firmata.connected?
    end

  end
end