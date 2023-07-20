# frozen_string_literal: false

require 'minitest/autorun'
require 'unisec'

class UnisecTest < Minitest::Test
  def test_unisec_properties_list
    assert_kind_of(Array, Unisec::Properties.list)
    assert_kind_of(String, Unisec::Properties.list.first)
  end

  def test_unisec_properties_codepoints
    cps = Unisec::Properties.codepoints('Quotation_Mark')
    assert_kind_of(Array, cps)
    assert_kind_of(Hash, cps.first)
    assert_equal(true, cps.first.has_key?(:char))
    assert_equal(true, cps.first.has_key?(:codepoint))
    assert_equal(true, cps.first.has_key?(:name))
  end

  def test_unisec_properties_char
    data = Unisec::Properties.char('é')
    assert_kind_of(Hash, data)
    assert_equal(true, data.has_key?(:age))
    assert_equal(true, data.has_key?(:block))
    assert_equal(true, data.has_key?(:category))
    assert_equal(true, data.has_key?(:subcategory))
    assert_equal(true, data.has_key?(:codepoint))
    assert_equal(true, data.has_key?(:name))
    assert_equal(true, data.has_key?(:script))
    assert_equal(true, data.has_key?(:case))
    assert_equal(true, data.has_key?(:normalization))
    assert_equal(true, data.has_key?(:other_properties))
    assert_equal('LATIN SMALL LETTER E WITH ACUTE', data[:name])
    assert_equal('U+00E9', data[:codepoint])
  end

  def test_unisec_properties_char2codepoint
    assert_equal('U+00E9', Unisec::Properties.char2codepoint('é'))
    assert_equal('U+0041', Unisec::Properties.char2codepoint('AZ'))
  end

  def test_unisec_properties_chars2codepoints
    assert_equal('U+00E9', Unisec::Properties.chars2codepoints('é'))
    assert_equal('U+0041 U+005A', Unisec::Properties.chars2codepoints('AZ'))
  end
end
