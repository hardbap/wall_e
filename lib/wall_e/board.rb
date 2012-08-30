
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

    def method_missing(method_name, *args)
      if method_name.to_s[/\Aset_pin_to_(output|input|pwm|pulse_width_modulation|servo)\z/]
        set_pin_to(args.first, send($1 + '_mode'))
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private)
      method_name.to_s[/\Aset_pin_to_(output|input|pwm|pulse_width_modulation|servo)\z/] || super
    end

    def set_pin_to(pin_number, mode)
      if pins[pin_number].supported_modes.include?(mode)
        @firmata.set_pin_mode(pin_number, mode)
      else
        # need to warn
      end
    end

    def input_mode
      firmata_const :INPUT
    end

    def output_mode
      firmata_const :OUTPUT
    end

    def pulse_width_modulation_mode
      firmata_const :PWM
    end
    alias_method :pwm_mode, :pulse_width_modulation_mode

    def servo_mode
      firmata_const :SERVO
    end

    def add_led(pin)
      Led.new(pin, self)
    end

    def firmata_const(sym)
      @firmata.class.const_get sym
    end
  end
end