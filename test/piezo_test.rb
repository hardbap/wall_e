require_relative 'test_helper'
require_relative '../lib/wall_e/pin'
require_relative '../lib/wall_e/components/piezo'

class PiezoTest < MiniTest::Unit::TestCase

  def test_turning_on
    note = 1136 # 'a'
    pin = MiniTest::Mock.new
    pin.expect(:set_mode, 1, [WallE::Pin::PWM])
    pin.expect(:analog_write, 1, [note])

    piezo = WallE::Piezo.new(pin)
    piezo.on(note)

    assert piezo.on?
    pin.verify
  end

  def test_turning_off
    pin = MiniTest::Mock.new
    pin.expect(:set_mode, 1, [WallE::Pin::PWM])
    pin.expect(:analog_write, 1, [0])

    piezo = WallE::Piezo.new(pin)
    piezo.off

    assert piezo.off?
    pin.verify
  end
end