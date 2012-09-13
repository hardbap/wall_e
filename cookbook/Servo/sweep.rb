require 'bundler/setup'
require 'wall_e'

WallE::Assembler.build do
  # This example uses a Sparkfun's "Medium" servo.
  # (DGServo S05NF STD http://www.sparkfun.com/products/10333)
  # Using the range 15..170 appears to be the sweet spot for this servo.
  #
  # YMMV especially if you are using a different servo.
  #
  # The Hitec HS-322 (http://amzn.com/B0006O3XEA) has a range of 2..180.
  servo = Servo(9, range: 15..170)
  servo.min

  repeat do

    servo.min if servo.maxed?

    servo.move_to(servo.position + 1)

    delay 0.01
  end

end