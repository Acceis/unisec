# Quick start

## Quick install

```
$ gem install unisec
```

## Default usage: CLI

Example converting surrogates to code point.

```
$ unisec surrogates from 0xD801 0xDC37
Char: 𐐷
Code Point: 0x10437, 0d66615, 0b10000010000110111
High Surrogate: 0xD801, 0d55297, 0b1101100000000001
Low Surrogate: 0xDC37, 0d56375, 0b1101110000110111
```

## Default usage: library

```ruby
require 'unisec'

surr = Unisec::Surrogates.new(55357, 56489)
surr.code_point # => 128169
```
