require_relative 'serial_snoop'

module WallE
  class Board
    attr_reader :firmata

    def initialize(&block)
      @firmata = SerialSnoop.locate_port

      yield self if firmata and block_given?

    end

  end
end