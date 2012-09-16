require 'wall_e/version'
require 'wall_e/serial_snoop'
require 'wall_e/pin'
require 'pry'

# TODO everything in components should be required automagically.
require 'wall_e/components/led'
require 'wall_e/components/servo'
require 'wall_e/components/piezo'

module WallE
  class Assembler

    attr_reader :board

    def self.build(&block)
      wall_e = create

      wall_e.instance_eval(&block) if block_given?

      Pry.start(wall_e, :prompt => [ proc { |obj, *| "wall_e > " },
                                     proc { |obj, *| "wall_e* "} ])
    end

    def self.create
      arduino = SerialSnoop.locate_ports
      new(arduino)
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

    # TODO some metaprogramming sauce to reduce the component helper code.
    def Led(pin_number)
      pin = Pin.new(pin_number, @board)
      Led.new(pin)
    end

    def Servo(pin_number, options = {})
      pin = Pin.new(pin_number, @board)
      Servo.new(pin, options)
    end

    def Piezo(pin_number)
      pin = Pin.new(pin_number, @board)
      Piezo.new(pin)
    end

    def delay(seconds)
      @board.delay seconds
    end

    def pause
      @running = false
    end

    def resume
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