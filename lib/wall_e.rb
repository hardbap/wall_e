require 'wall_e/version'
require 'wall_e/board'
require 'pry'

module WallE
  extend self

  def run(&block)

    board = Board.new

    Thread.new do
      loop do
        begin
          board.firmata.read_and_process
          sleep(0.5)
        rescue Exception => e
          puts e.message
          puts e.backtrace.inspect
          Thread.kill
        end
      end
    end

    yield board

    Pry.start(board, :prompt => [ proc { |obj, *| "wall_e > " }, proc { |obj, *| "wall_e* "} ])
  end

end