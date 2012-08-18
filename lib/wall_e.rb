require 'wall_e/version'
require 'wall_e/serial_snoop'
require 'bundler/setup'

module WallE
  class Board
    include SerialSnoop
    include Logger

    attr_reader :board

    def initialize
      @board = identify
    end

  end
end
