require 'wall_e/version'
require 'wall_e/serial_snoop'
require 'wall_e/board'
require 'pry'


module WallE
  class Assembler

    attr_reader :board

    def self.build(&block)

      arduino = SerialSnoop.locate_ports

      wall_e = new(arduino)

      wall_e.instance_eval(&block)

      Pry.start(wall_e, :prompt => [ proc { |obj, *| "wall_e > " }, proc { |obj, *| "wall_e* "} ])
    end

    def initialize(arduino)
      @board = arduino
      @board.connect unless arduino.connected?
      @running = true
      @group = ThreadGroup.new

       Thread.new do
        loop do
          begin
            arduino.read_and_process
            sleep(0.5)
          rescue Exception => e
            puts e.message
            puts e.backtrace.inspect
            Thread.kill
          end
        end
      end
    end

    def Led(pin_number)
      pin = Pin.new(pin_number, @board)
      Led.new(pin)
    end

    def pause
      @running = false
    end

    def restart
      @running = true
      @group.list.each(&:wakeup)
    end

    def turn_off
      @group.list.each(&:kill)
    end

    def repeat(&block)
      t = Thread.new do
        loop do
          Thread.stop unless @running
            begin
              block.call
            rescue Exception => e
              puts e.message
              puts e.backtrace.inspect
              Thread.kill
            end
        end
      end

      @group.add(t)
    end
  end
end