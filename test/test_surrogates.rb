# frozen_string_literal: false

require 'minitest/autorun'
require 'unisec'

class UnisecTest < Minitest::Test
  def test_unisec_surrogates_equals_attrs
    surr1 = Unisec::Surrogates.new(128169) # 💩
    surr2 = Unisec::Surrogates.new(55357, 56489) # 💩

    assert_equal(surr1.cp, surr2.cp)
    assert_equal(surr1.hs, surr2.hs)
    assert_equal(surr1.ls, surr2.ls)
    assert_equal(surr1.code_point, surr2.code_point)
    assert_equal(surr1.high_surrogate, surr2.high_surrogate)
    assert_equal(surr1.low_surrogate, surr2.low_surrogate)
  end

  def test_unisec_surrogates_code_point
    assert_equal(0x10000, Unisec::Surrogates.code_point(0xD800, 0xDC00)) # 𐀀
    assert_equal(0x1FF00, Unisec::Surrogates.code_point(0xD83F, 0xDF00)) # 🼀
    assert_equal(0x1F600, Unisec::Surrogates.code_point(0xD83D, 0xDE00)) # 😀
  end

  def test_unisec_surrogates_high_surrogate
    assert_equal(0xD835, Unisec::Surrogates.high_surrogate(0x1D400)) # 𝐀
    assert_equal(0xD837, Unisec::Surrogates.high_surrogate(0x1DF00)) # 𝼀
    assert_equal(0xD83C, Unisec::Surrogates.high_surrogate(0x1F300)) # 🌀
  end

  def test_unisec_surrogates_low_surrogate
    assert_equal(0xDF00, Unisec::Surrogates.low_surrogate(0x10300)) # 𐜀
    assert_equal(0xDE00, Unisec::Surrogates.low_surrogate(0x11A00)) # 𑨀
    assert_equal(0xDD00, Unisec::Surrogates.low_surrogate(0x12500)) # 𒔀
  end
end
