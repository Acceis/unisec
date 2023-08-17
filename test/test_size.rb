# frozen_string_literal: false

require 'minitest/autorun'
require 'unisec'

class UnisecTest < Minitest::Test
  def setup
    @zwj = '👩‍❤️‍👩'
    @josé = 'J̲o̲s̲é̲'
  end

  def test_unisec_size_code_points_size
    assert_equal(6, Unisec::Size.code_points_size(@zwj))
    assert_equal(9, Unisec::Size.code_points_size(@josé))
  end

  def test_unisec_size_grapheme_size
    assert_equal(1, Unisec::Size.grapheme_size(@zwj))
    assert_equal(4, Unisec::Size.grapheme_size(@josé))
  end

  def test_unisec_size_utf8_bytesize
    assert_equal(20, Unisec::Size.utf8_bytesize(@zwj))
    assert_equal(14, Unisec::Size.utf8_bytesize(@josé))
  end

  def test_unisec_size_utf16_bytesize
    assert_equal(16, Unisec::Size.utf16_bytesize(@zwj))
    assert_equal(18, Unisec::Size.utf16_bytesize(@josé))
  end

  def test_unisec_size_utf32_bytesize
    assert_equal(24, Unisec::Size.utf32_bytesize(@zwj))
    assert_equal(36, Unisec::Size.utf32_bytesize(@josé))
  end

  def test_unisec_size_utf8_unitsize
    assert_equal(20, Unisec::Size.utf8_unitsize(@zwj))
    assert_equal(14, Unisec::Size.utf8_unitsize(@josé))
  end

  def test_unisec_size_utf16_unitsize
    assert_equal(8, Unisec::Size.utf16_unitsize(@zwj))
    assert_equal(9, Unisec::Size.utf16_unitsize(@josé))
  end

  def test_unisec_size_utf32_unitsize
    assert_equal(6, Unisec::Size.utf32_unitsize(@zwj))
    assert_equal(9, Unisec::Size.utf32_unitsize(@josé))
  end
end
