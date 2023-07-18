# frozen_string_literal: false

require 'minitest/autorun'
require 'unisec'

class UnisecTest < Minitest::Test
  def test_unisec_hexdump_utf8
    assert_equal('f0 9f a6 93', Unisec::Hexdump.utf8('🦓'))
    assert_equal('f0 9f a7 91 e2 80 8d f0 9f 9a 80 20 67 6f 65 73 20 69 6e 20 f0 9f 9a 80 e2 9c a8', Unisec::Hexdump.utf8('🧑‍🚀 goes in 🚀✨'))
  end

  def test_unisec_hexdump_utf16be
    assert_equal('d83e dd93', Unisec::Hexdump.utf16be('🦓'))
    assert_equal('d83e ddd1 200d d83d de80 0020 0067 006f 0065 0073 0020 0069 006e 0020 d83d de80 2728', Unisec::Hexdump.utf16be('🧑‍🚀 goes in 🚀✨'))
  end

  def test_unisec_hexdump_utf16le
    assert_equal('3ed8 93dd', Unisec::Hexdump.utf16le('🦓'))
    assert_equal('3ed8 d1dd 0d20 3dd8 80de 2000 6700 6f00 6500 7300 2000 6900 6e00 2000 3dd8 80de 2827', Unisec::Hexdump.utf16le('🧑‍🚀 goes in 🚀✨'))
  end

  def test_unisec_hexdump_utf32be
    assert_equal('0001f993', Unisec::Hexdump.utf32be('🦓'))
    assert_equal('0001f9d1 0000200d 0001f680 00000020 00000067 0000006f 00000065 00000073 00000020 00000069 0000006e 00000020 0001f680 00002728', Unisec::Hexdump.utf32be('🧑‍🚀 goes in 🚀✨'))
  end

  def test_unisec_hexdump_utf32le
    assert_equal('93f90100', Unisec::Hexdump.utf32le('🦓'))
    assert_equal('d1f90100 0d200000 80f60100 20000000 67000000 6f000000 65000000 73000000 20000000 69000000 6e000000 20000000 80f60100 28270000', Unisec::Hexdump.utf32le('🧑‍🚀 goes in 🚀✨'))
  end
end
