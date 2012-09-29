require_relative 'test_helper'
require_relative '../lib/wall_e/pin'
require 'ostruct'


DummyBoard = Class.new do
  attr_reader :pins

  def initialize(pins)
    @pins = pins
  end

  def digital_write(*args); args.length; end
  def set_pin_mode(pin_number, mode); pin_number; end
end

class PinTest < MiniTest::Unit::TestCase

  def test_will_not_set_to_a_mode_pin_does_not_support
    board_pins = []
    board_pins.insert(13, OpenStruct.new(supported_modes: Array(0..3)))

    board = DummyBoard.new(board_pins)

    pin = WallE::Pin.new(13, board)

    assert_raises(WallE::Pin::UnsupportedModeError) { pin.set_mode WallE::Pin::SERVO }
  end

  def test_set_mode_will_only_set_changes
    pin_number = 13
    board_pins = []
    board_pins.insert(pin_number, OpenStruct.new(supported_modes: Array(0..4)))

    board = OpenStruct.new(pins: board_pins, set_pin_mode: 1)

    pin = nil

    board.stub :set_pin_mode, 1 do
      pin = WallE::Pin.new(pin_number, board, WallE::Pin::PWM)
    end

    pin.stub :current_mode, WallE::Pin::PWM do
      pin.set_mode WallE::Pin::PWM
    end
  end

  def test_digital_write_to_board
    pin_number = 13
    board_pins = []
    board_pins.insert(pin_number, OpenStruct.new(supported_modes: Array(0..3)))

    board = MiniTest::Mock.new
    board.expect(:pins, board_pins)
    board.expect(:set_pin_mode, 1, [pin_number, WallE::Pin::OUTPUT])
    board.expect(:digital_write, 1, [pin_number, 1])

    pin = WallE::Pin.new(pin_number, board)

    pin.digital_write(1)

    board.verify
  end

  def test_analog_write_to_board
    pin_number = 13
    board_pins = []
    board_pins.insert(pin_number, OpenStruct.new(supported_modes: Array(0..4)))

    board = MiniTest::Mock.new
    board.expect(:pins, board_pins)
    board.expect(:set_pin_mode, 1, [pin_number, WallE::Pin::PWM])
    board.expect(:analog_write, 1, [pin_number, 255])

    pin = WallE::Pin.new(pin_number, board, WallE::Pin::PWM)

    pin.analog_write(255)

    board.verify
  end

  def test_pin_not_in_input_mode_cannot_report
    board_pins = []
    board_pins.insert(13, OpenStruct.new(mode: WallE::Pin::PWM, supported_modes: Array(0..3)))

    board = DummyBoard.new(board_pins)

    pin = WallE::Pin.new(13, board)

    assert_raises(WallE::Pin::UnsupportedModeError) do
      pin.start_reporting
    end
  end

  def test_start_pin_reporting
    pin_number = 13
    board_pins = []
    board_pins.insert(pin_number, OpenStruct.new(mode: WallE::Pin::INPUT, supported_modes: Array(0..4)))

    board = MiniTest::Mock.new
    board.expect(:pins, board_pins)
    board.expect(:toggle_pin_reporting, true, [pin_number])

    pin = WallE::Pin.new(pin_number, board, WallE::Pin::INPUT)

    pin.start_reporting

    board.verify
  end

  def test_stop_pin_reporting
    pin_number = 13
    board_pins = []
    board_pins.insert(pin_number, OpenStruct.new(mode: WallE::Pin::INPUT, supported_modes: Array(0..4)))

    board = MiniTest::Mock.new
    board.expect(:pins, board_pins)
    board.expect(:toggle_pin_reporting, true, [pin_number, WallE::Pin::LOW])

    pin = WallE::Pin.new(pin_number, board, WallE::Pin::INPUT)

    pin.stop_reporting

    board.verify
  end
end