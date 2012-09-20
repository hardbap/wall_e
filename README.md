# Wall&middot;E

Ruby powered robots.

## Shout-outs

Wall&middot;E would not have been possible if not for the awesome goings on in
the Node community. Big props to:

* [Rick Waldron](https://github.com/rwldrn) creator of [johnny-five](https://github.com/rwldrn/johnny-five)
* [Chris Williams](https://github.com/voodootikigod) creator of [node-serialport](https://github.com/voodootikigod/node-serialport)
* [Julian Gautier](https://github.com/jgautier) creator [firmata](https://github.com/jgautier/firmata)

## Prerequisites

1. Download and install the [Arduio IDE](http://www.arduino.cc/en/Main/Software) for your OS
2. Download and unzip [Firmata 2.2](http://at.or.at/hans/pd/Firmata-2.2.zip)
3. Plug in your Arduino via USB
4. Open the Arduino IDE, select: File > Open > [Path from step 2] > examples > StandardFirmata
5. Click the Upload button

## Installation

Add this line to your application's Gemfile:

    gem 'wall_e'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wall_e

## Usage

    require 'wall_e'

    WallE::Assembler.build do

      led = Led(3)
      rate = 0.75

      repeat do
        led.toggle
        delay rate
      end

    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

