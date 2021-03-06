require 'wall_e/version'
require 'wall_e/serial_snoop'
require 'wall_e/pin'
require 'pry'

# TODO everything in components should be required automagically.
require 'wall_e/components/led'
require 'wall_e/components/servo'
require 'wall_e/components/piezo'
require 'wall_e/components/claw'
require 'wall_e/components/button'

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
      (leds << Led.new(pin)).last
    end

    def Servo(pin_number, options = {})
      pin = Pin.new(pin_number, @board)
      (servos << Servo.new(pin, options)).last
    end

    def Piezo(pin_number)
      pin = Pin.new(pin_number, @board)
      (piezos << Piezo.new(pin)).last
    end

    def Claw(claw_pin_number, pan_pin_number)
      claw_servo = Servo(claw_pin_number, range: 60..144)
      pan_servo  = Servo(pan_pin_number)
      (claws << Claw.new(claw_servo, pan_servo)).last
    end

    def Button(pin_number)
      pin = Pin.new(pin_number, @board)
      (buttons << Button.new(pin)).last
    end

    # TODO wrap up these collections in some metaprogramming sauce too.
    def leds
      @leds ||= []
    end

    def servos
      @servos ||= []
    end

    def piezos
      @piezos ||= []
    end

    def claws
      @claws ||= []
    end

    def buttons
      @buttons ||= []
    end

    def delay(seconds)
      @board.delay seconds
    end

    def pause
      @running = false
    end

    def resume
      @group.list.each(&:wakeup)
      @running = true
    end

    def shut_down
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