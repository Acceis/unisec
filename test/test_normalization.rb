# frozen_string_literal: false

require 'minitest/autorun'
require 'unisec'

class UnisecTest < Minitest::Test
  def test_unisec_normalization
    assert_equal("\u{1E9B 0323}", Unisec::Normalization.nfc("\u{1E9B 0323}"))
    assert_equal("\u{1E69}", Unisec::Normalization.nfkc("\u{1E9B 0323}"))
    assert_equal("\u{017F 0323 0307}", Unisec::Normalization.nfd("\u{1E9B 0323}"))
    assert_equal("\u{0073 0323 0307}", Unisec::Normalization.nfkd("\u{1E9B 0323}"))
    assert_equal("\u{2126}", Unisec::Normalization.new("\u{2126}").original)
  end
end
