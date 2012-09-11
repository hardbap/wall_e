require 'bundler/setup'
require 'wall_e'

WallE::Assembler.build do

  servo = Servo(9)
  servo.min

  repeat do

    servo.min if servo.maxed?

    servo.move_to(servo.position + 1)

    delay 0.01
  end

end