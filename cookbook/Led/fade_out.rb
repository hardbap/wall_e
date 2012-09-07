require 'bundler/setup'
require 'wall_e'

WallE::Assembler.build do

  led = Led(9)
  led.brightness(255)

  repeat do
    turn_off if led.value == 0

    led.brightness(led.value - 1)

    delay 0.01
  end
end