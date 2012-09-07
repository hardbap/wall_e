require 'bundler/setup'
require 'wall_e'

WallE::Assembler.build do

  led = Led(9)

  repeat do

    if led.value == 255
      led.off
      turn_off
    end

    led.brightness(led.value + 1)

    delay 0.01
  end
end