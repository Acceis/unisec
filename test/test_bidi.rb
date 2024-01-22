# frozen_string_literal: false

require 'minitest/autorun'
require 'unisec'

class UnisecTest < Minitest::Test
  def test_unisec_bidi_spoof_init
    input = 'https://moc.example.org//:sptth'
    bd = Unisec::Bidi::Spoof.new(input)
    rlo = "\u{202E}"
    pdf = "\u{202C}"

    assert_equal(input, bd.target_display)
    assert_kind_of(String, bd.spoof_string)
    assert_kind_of(String, bd.spoof_payload)
    refute_includes(bd.spoof_string, rlo)
    refute_includes(bd.spoof_string, pdf)
    assert_includes(bd.spoof_payload, rlo)
    assert_includes(bd.spoof_payload, pdf)
  end

  def test_unisec_bidi_spoof_init_options
    input = 'acceis'
    rli = "\u{2067}"
    pdi = "\u{2069}"

    bd1 = Unisec::Bidi::Spoof.new(input, prefix: rli, suffix: pdi)

    refute_includes(bd1.spoof_string, rli)
    refute_includes(bd1.spoof_string, pdi)
    assert_includes(bd1.spoof_payload, rli)
    assert_includes(bd1.spoof_payload, pdi)
  end

  def test_unisec_bidi_spoof_reverse
    text = "aeiou\u0308yz🇫🇷🐓👦🏻👋"
    # With default options, applying two times should give back the original input
    assert_equal(text, Unisec::Bidi::Spoof.reverse(Unisec::Bidi::Spoof.reverse(text)))

    # sub-string reverse
    assert_equal('document_annexe.txt', Unisec::Bidi::Spoof.reverse('document_anntxt.exe', index: 12))
  end

  def test_unisec_bidi_spoof_bidi_affix
    # By default inject a RLO prefix, a PDF suffix and no infix.
    assert_equal('‮acceis‬', Unisec::Bidi::Spoof.bidi_affix('acceis'))
    # RLI ... PDI
    assert_equal('⁧acceis⁩', Unisec::Bidi::Spoof.bidi_affix('acceis', prefix: "\u{2067}", suffix: "\u{2069}"))
    # RLE ... PDF
    assert_equal('‫acceis‬', Unisec::Bidi::Spoof.bidi_affix('acceis', prefix: "\u{202B}", suffix: "\u{202C}"))
    # RLO ... PDF
    assert_equal('‮https://moc.example.org//:sptth‬',
                 Unisec::Bidi::Spoof.bidi_affix('https://moc.example.org//:sptth', prefix: "\u{202E}", suffix: "\u{202C}"))
    # FSI RLO ... PDF PDI
    assert_equal('⁨‮https://moc.example.org//:sptth‬⁩',
                 Unisec::Bidi::Spoof.bidi_affix('https://moc.example.org//:sptth', prefix: "\u{2068 202E}", suffix: "\u{202C 2069}"))
    # RLM ...
    assert_equal('‏unicode', Unisec::Bidi::Spoof.bidi_affix('unicode', prefix: "\u{200F}", suffix: ''))
    # For file name spoofing, it is useful to be able to inject just a RLO before the fake extension
    # so we can void the prefix and suffix and just set the position of an infix
    assert_equal('document_ann‮txt.exe',
                 Unisec::Bidi::Spoof.bidi_affix('document_anntxt.exe', prefix: '', suffix: '', infix_bidi: "\u{202E}", infix_pos: 12))
  end
end
