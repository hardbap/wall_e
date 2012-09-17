require 'bundler/setup'
require 'wall_e'

class MorseCode

  LETTERS = {
    "a" => ".-",
    "b" => "-...",
    "c" => "-.-.",
    "d" => "-..",
    "e" => ".",
    "f" => "..-.",
    "g" => "--.",
    "h" => "....",
    "i" => "..",
    "j" => ".---",
    "k" => "-.-",
    "l" => ".-..",
    "m" => "--",
    "o" => "---",
    "p" => ".--.",
    "q" => "--.-",
    "r" => ".-.",
    "s" => "...",
    "t" => "-",
    "u" => "..-",
    "v" => "...-",
    "w" => ".--",
    "x" => "-..-",
    "y" => "-.--",
    "z" => "--.."
  }

  def initialize(piezo)
    @piezo = piezo
    @dit_length = 0.15
    @dah_length = @dit_length * 3
    @space_length = @dit_length * 7
    @tone = 1275
  end

  def dit
    puts '.'
    output(@dit_length)
  end

  def dah
    puts '-'
    output(@dah_length)
  end

  def output(duration)
    @piezo.on(@tone)
    sleep(duration)
    @piezo.off
    sleep(@dit_length)
  end

  def say(string)
    string.each_char do |letter|
      pattern = LETTERS[letter.downcase]
      if pattern.nil?
        sleep @space_length
      else
        pattern.each_char do |p|
          case p
          when '.' then dit
          when '-' then dah
          end
        end
        sleep @dah_length
      end
    end
  end
end

WallE::Assembler.build do
  piezo = Piezo(6)

  mc = MorseCode.new(piezo)

  mc.say('Hello World')
end