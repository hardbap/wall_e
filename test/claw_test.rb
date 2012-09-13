require_relative 'test_helper'
require_relative '../lib/wall_e/components/claw'

class ClawTest < MiniTest::Unit::TestCase

  DummyServo = Class.new

  def test_let_go
    claw_servo = MiniTest::Mock.new
    claw_servo.expect :min, 1
    pan_servo = DummyServo.new

    claw = WallE::Claw.new(claw_servo, pan_servo)

    claw.let_go

    claw_servo.verify
  end

  def test_grab
    claw_servo = MiniTest::Mock.new
    claw_servo.expect :max, 1
    pan_servo = DummyServo.new

    claw = WallE::Claw.new(claw_servo, pan_servo)

    claw.grab

    claw_servo.verify
  end

  def test_tilting
    pan_servo = MiniTest::Mock.new
    pan_servo.expect :min, 1
    pan_servo.expect :max, 1
    pan_servo.expect :center, 1
    claw_servo = DummyServo.new

    claw = WallE::Claw.new(claw_servo, pan_servo)

    claw.min
    claw.max
    claw.center

    pan_servo.verify
  end
end