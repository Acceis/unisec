# frozen_string_literal: false

require 'minitest/autorun'
require 'unisec'

class UnisecTest < Minitest::Test
  def test_unisec_versions_versions
    data = Unisec::Versions.versions
    assert_kind_of(Hash, data)
    data.each do |_k, v|
      assert(v.key?(:version))
      assert(v.key?(:label))
    end
  end
end
