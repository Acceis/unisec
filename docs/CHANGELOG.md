## [unreleased]

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
