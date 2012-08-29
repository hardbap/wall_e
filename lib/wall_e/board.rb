require_relative 'serial_snoop'

module WallE
  class Board
    extend SerialSnoop

    attr_reader :firmata

    def initialize(&block)
      firmata = locate

      yield self if firmata and block_given?

    end

  end
end