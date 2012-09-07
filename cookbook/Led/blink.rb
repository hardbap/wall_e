require 'bundler/setup'
require 'wall_e'

WallE::Assembler.build do

  led = Led(9)
  rate = 0.75

  repeat do
    led.toggle
    delay rate
  end

end