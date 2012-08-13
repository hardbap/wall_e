require 'wall_e/version'
require 'wall_e/serial_snoop'

module WallE
  class Board
    include SerialSnoop
    include EventSpitter
=begin
IRB.setup nil
IRB.conf[:MAIN_CONTEXT] = IRB::Irb.new.context
require 'irb/ext/multi-irb'

IRB.conf[:PROMPT][:MY_PROMPT] = { # name of prompt mode
  :PROMPT_I => "firmata> ",             # normal prompt
  :PROMPT_S => "...",             # prompt for continuing strings
  :PROMPT_C => "...",             # prompt for continuing statement
  :RETURN => "    ==>%s\n"        # format to return value
}
IRB.conf[:PROMPT_MODE] = :MY_PROMPT
IRB.irb nil, board

=end

    attr_reader :board

    def initialize
      @board = identify
    end
=begin
  Thread.new do
  loop do
    board.process
    sleep 1
  end
end
=end
  end
end
