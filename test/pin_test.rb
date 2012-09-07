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
end