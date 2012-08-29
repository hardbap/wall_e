require 'wall_e/version'
require 'wall_e/serial_snoop'

module WallE
  class Board
    extend SerialSnoop

    attr_reader :firmata

    def initialize(&block)
      firmata = identify

      yield self if firmata and block_given?

    end

  end
end
