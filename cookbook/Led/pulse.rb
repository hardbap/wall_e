require 'bundler/setup'
require 'wall_e'

WallE::Assembler.build do

  led = Led(9)

  direction = 1000 / (255 * 2)

  repeat do

    direction = 1 if led.value.zero?

    direction = -1 if led.value == 255

    led.brightness(led.value + direction)

    delay 0.01
  end
end