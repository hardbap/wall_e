require_relative 'logger'
require 'firmata'

module WallE
  module SerialSnoop
    include Logger

    def locate
      ports = Dir['/dev/*'].grep(/usb|acm/)
      board = nil

      if ports.any?
        what = 'serial port'
        what << 's' unless ports.one?

        info "Found possible #{what} #{ports}"

        # TODO refactor to own method
        ports.each do |port|
          begin
            info "Connecting to #{port}..."
            board = Firmata::Board.new(port)
            info "Connected to #{port}."
            break # we've found a board
          rescue => e
            error e.message
            board = nil
          end
        end

      else
        error 'Error: No USB devices detected'
      end

      error 'Error: Unable to connect to USB device' unless board

      board
    end
  end
end