require_relative 'test_helper'
require_relative '../lib/wall_e/pin'
require_relative '../lib/wall_e/components/servo'

class ServoTest < MiniTest::Unit::TestCase

  def test_set_pin_mode_to_servo
    pin = MiniTest::Mock.new
    pin.expect(:set_mode, 1, [WallE::Pin::SERVO])

    servo = WallE::Servo.new(pin)

    pin.verify
  end

  def test_move_to
    pin = MiniTest::Mock.new
    pin.expect(:set_mode, 1, [WallE::Pin::SERVO])
    pin.expect(:servo_write, 1, [90])

    servo = WallE::Servo.new(pin)
    servo.move_to(90)

    pin.verify
  end

  def test_move_to_will_not_move_past_bounds
    pin = MiniTest::Mock.new
    pin.expect(:set_mode, 1, [WallE::Pin::SERVO])

    servo = WallE::Servo.new(pin)

    assert_raises(WallE::Servo::OutOfBoundsError) { servo.move_to(181) }
  end

  def test_moving_to_min
    pin = MiniTest::Mock.new
    pin.expect(:set_mode, 1, [WallE::Pin::SERVO])
    pin.expect(:servo_write, 1, [0])

    servo = WallE::Servo.new(pin)
    servo.min

    pin.verify
  end

   def test_moving_to_max
    pin = MiniTest::Mock.new
    pin.expect(:set_mode, 1, [WallE::Pin::SERVO])
    pin.expect(:servo_write, 1, [180])

    servo = WallE::Servo.new(pin)
    servo.max

    pin.verify
  end

  def test_moving_to_center
    pin = MiniTest::Mock.new
    pin.expect(:set_mode, 1, [WallE::Pin::SERVO])
    pin.expect(:servo_write, 1, [90])

    servo = WallE::Servo.new(pin)
    servo.center

    pin.verify
  end

end