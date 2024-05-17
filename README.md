# unisec

[![GitHub forks](https://img.shields.io/github/forks/acceis/unisec)](https://github.com/acceis/unisec/network)
[![GitHub stars](https://img.shields.io/github/stars/acceis/unisec)](https://github.com/acceis/unisec/stargazers)
[![GitHub license](https://img.shields.io/github/license/acceis/unisec)](https://github.com/acceis/unisec/blob/master/LICENSE)
[![Rawsec's CyberSecurity Inventory](https://inventory.raw.pm/img/badges/Rawsec-inventoried-FF5050_flat.svg)](https://inventory.raw.pm/tools.html#unisec)

![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/acceis/unisec/ruby.yml?branch=master)
![GitHub commit activity](https://img.shields.io/github/commit-activity/y/acceis/unisec)

![](https://acceis.github.io/unisec/_media/unisec-logo.png)

> Unicode Security Toolkit

## What is it?

A CLI tool and library to play with Unicode security.

## Features

- **BiDi spoofing**
  - Craft payloads for attack using BiDi code points (e.g. spoofing a domain name or a file name)
- **Confusables / homoglyphs**
  - List confusables characters for a given character
  - Replace all characters from a string with random confusables
- **Hexdump**
  - UTF-8, UTF-16, UTF-32 hexadecimal dumps
- **Normalization**
  - NFC, NFKC, NFD, NFKD normalization forms, HTML escape bypass for XSS
- **Properties**
  - Get all properties of a given Unicode character
  - List code points matching a Unicode property
  - List all Unicode properties name
- **Regexp search**
  - Search for Unicode code point names by regular expression
- **Size**
  - Code point, grapheme, UTF-8/UTF-16/UTF-32 byte/unit size
- **Surrogates**
  - Code point ↔️ Surrogates conversion
- **Versions**
  - Version of Unicode, ICU, CLDR, UCD, gems used in Unisec

## Installation

```plaintext
$ gem install unisec
```

Check the [installation](https://acceis.github.io/unisec/#/pages/install) page on the documentation to discover more methods.

[![Packaging status](https://repology.org/badge/vertical-allrepos/unisec.svg)](https://repology.org/project/unisec/versions)
[![Gem Version](https://badge.fury.io/rb/unisec.svg)](https://badge.fury.io/rb/unisec)
![GitHub tag (latest SemVer)](https://img.shields.io/github/tag/acceis/unisec)

## Documentation

Homepage / Documentation: https://acceis.github.io/unisec/

## Author

Made by Alexandre ZANNI ([@noraj](https://pwn.by/noraj/)) at [ACCEIS](https://www.acceis.fr/).
