# frozen_string_literal: false

require 'minitest/autorun'
require 'unisec'

class UnisecTest < Minitest::Test
  def test_unisec_rugrep_regrep
    search = Unisec::Rugrep.regrep('large \w+ square')
    assert_kind_of(Array, search)
    assert(search.first.has_key?(:char))
    assert(search.first.has_key?(:codepoint))
    assert(search.first.has_key?(:name))
    assert_kind_of(String, search.first[:char])
    assert_kind_of(Integer, search.first[:codepoint])
    assert_kind_of(String, search.first[:name])
    search2 = Unisec::Rugrep.regrep('azerty')
    assert_kind_of(Array, search2)
    assert_empty(search2)
  end

  def test_unisec_rugrep_ucd_derivedname_version
    assert(/\A\d+\.\d+\.\d+\Z/.match?(Unisec::Rugrep.ucd_derivedname_version))
  end
end
