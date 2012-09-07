require_relative 'test_helper'
require_relative '../lib/wall_e/pin'
require_relative '../lib/wall_e/components/led'



class LedTest < MiniTest::Unit::TestCase

  def test_turning_on
    pin = MiniTest::Mock.new
    pin.expect(:set_mode, 1, [WallE::Pin::OUTPUT])
    pin.expect(:digital_write, 1, [WallE::Pin::HIGH])

    led = WallE::Led.new(pin)

    led.on

    assert led.on?
    pin.verify
  end

  def test_turning_off
    pin = MiniTest::Mock.new
    pin.expect(:set_mode, 1, [WallE::Pin::OUTPUT])
    pin.expect(:digital_write, 1, [WallE::Pin::LOW])

    led = WallE::Led.new(pin)

    led.off

    assert led.off?
    pin.verify
  end

  def test_toggle
    pin = MiniTest::Mock.new
    pin.expect(:set_mode, 1, [WallE::Pin::OUTPUT])
    pin.expect(:digital_write, 1, [WallE::Pin::HIGH])

    led = WallE::Led.new(pin)

    led.toggle

    assert led.on?, 'led not toggled on'
    pin.verify

    pin.expect(:set_mode, 1, [WallE::Pin::OUTPUT])
    pin.expect(:digital_write, 1, [WallE::Pin::LOW])

    led.toggle

    assert led.off?, 'led not toggled off'
    pin.verify
  end

  def test_brightness
    pin = MiniTest::Mock.new
    pin.expect(:set_mode, 1, [WallE::Pin::PWM])
    pin.expect(:analog_write, 1, [255])

    led = WallE::Led.new(pin)

    led.brightness(255)
    pin.verify
  end
end