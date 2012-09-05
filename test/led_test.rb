require_relative 'test_helper'
require_relative '../lib/wall_e/components/led'

class FakeBoard
  def set_pin_to_output(pin_number); end
  def digital_write(pin_number); end
end

class LedTest < MiniTest::Unit::TestCase

  def turning_the_led_on
    led = WallE::Led.new(13, FakeBoard.new)
  end

end