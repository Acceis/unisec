## [unreleased]

## [0.0.6]

**Features**

- _Prepare a XSS payload for HTML escape bypass (HTML escape followed by NFKC / NFKD normalization)_
  - Rename CLI command `normalize` into `normalize all`
  - Add a new method `replace_bypass` in the class `Unisec::Normalization`
  - Add a new CLI command `normalize replace` (using the new `replace_bypass` method)

## [0.0.5]

**Features**

- Add a new class `Unisec::Normalization` and CLI command `normalize` to output all normalization forms

**Chore**

- Enhance documentation
- Dependencies update

## [0.0.4]

**Features**

- Add a new class `Unisec::Bidi::Spoof` and CLI command `bidi spoof` to craft payloads for attack using BiDi code points like RtLO, for example, for spoofing a domain name or a file name
- Add a new helper method: `Unisec::Utils::String.grapheme_reverse`: Reverse a string by graphemes (not by code points)
- Add an `--enc` option for `unisec hexdump` to output only in the specified encoding
- `unisec hexdump` can now read from STDIN if the input equals to `-`

## [0.0.3]

**Features**

- Add a new class `Unisec::Rugrep` and CLI command `grep` to search for Unicode code point names by regular expression
- Add a new method `Unisec::Properties.deccp2stdhexcp`: Convert from decimal code point to standardized format hexadecimal code point

**Chore**

- Enhance tests: `assert_equal(true, test)` ➡️ `assert(test)`
- Enhance SEO: better description

## [0.0.2]

- Add 2 new classes (and corresponding CLI command):
  - `Unisec::Versions`: Version of Unicode, ICU, CLDR, gems used in Unisec
  - `Unisec::Size`: Code point, grapheme, UTF-8/UTF-16/UTF-32 byte/unit size

## [0.0.1]

- Initial version
