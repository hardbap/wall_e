require_relative 'test_helper'

require_relative '../lib/wall_e/serial_snoop'

class Dummy; end

class SerialSnoopTest < MiniTest::Unit::TestCase

  def test_no_port_available
    Dir.stub :[], [] do
      assert_nil WallE::SerialSnoop.locate_ports
    end
  end

  def test_cannot_connect_to_found_port
    Dir.stub :[], ['tty.usbmodemfd13131'] do
      assert_nil WallE::SerialSnoop.locate_ports
    end
  end

  def test_connect_to_found_port
    Dir.stub :[], ['tty.usbmodemfd13131'] do
      Firmata::Board.stub :new, Dummy.new do
        refute_nil WallE::SerialSnoop.locate_ports
      end
    end
  end

end