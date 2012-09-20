require 'bundler/setup'
require 'wall_e'

WallE::Assembler.build do

  button = Button(7)
  led = Led(13) # use the onboard LED on pin 13

  button.pressed { led.toggle }

end