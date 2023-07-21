# frozen_string_literal: false

require 'minitest/autorun'
require 'unisec'

class UnisecTest < Minitest::Test
  def test_unisec_confusables_list
    data = Unisec::Confusables.list('!')
    assert_kind_of(Array, data)
    assert_kind_of(String, data.first)
    assert_equal(['！', 'ǃ', 'ⵑ', '‼', '⁉', '⁈'], data)
  end

  def test_unisec_confusables_randomize
    assert_kind_of(String, Unisec::Confusables.randomize('noraj'))
    # Should not fail when then is no confusable alternative
    assert_equal('é🚀', Unisec::Confusables.randomize('é🚀'))
  end
end
