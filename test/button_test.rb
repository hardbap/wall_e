require_relative 'test_helper'
require_relative '../lib/wall_e/components/button'

class ButtonTest < MiniTest::Unit::TestCase
  DummyPin = Class.new do
    def set_mode(mode); end
    def start_reporting; end
    def number; 7; end
    def on(*args); end
  end

  def test_sets_up_pin
    pin = MiniTest::Mock.new
    pin.expect(:set_mode, 1, [WallE::Pin::INPUT])
    pin.expect(:start_reporting, 1)
    pin.expect(:number, 7)
    pin.expect(:on, 1, ['digital-read-7', Method])

    WallE::Button.new(pin)

    pin.verify
  end

  def test_pressed
    blk = MiniTest::Mock.new
    blk.expect(:run, nil)

    button = WallE::Button.new(DummyPin.new)
    button.pressed { blk.run }

    button.handler(1)

    blk.verify
  end

  def test_released
    blk = MiniTest::Mock.new
    blk.expect(:run, nil)

    button = WallE::Button.new(DummyPin.new)
    button.released { blk.run }

    button.pressed {  }
    button.handler(1)

    button.handler(0)

    blk.verify
  end

  def test_held
    blk = MiniTest::Mock.new
    blk.expect(:run, nil)

    button = WallE::Button.new(DummyPin.new, 0.2)
    button.held { blk.run }
    button.released { }
    button.pressed { }
    button.handler(1)
    sleep 0.2
    button.handler(0)

    blk.verify
  end
end