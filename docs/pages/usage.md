# Usage

## CLI

### General help

List commands:

```
$ unisec --help
Commands:
  unisec bidi [SUBCOMMAND]
  unisec confusables [SUBCOMMAND]
  unisec grep REGEXP                              # Search for Unicode code point names by regular expression
  unisec hexdump INPUT                            # Hexdump in all Unicode encodings
  unisec properties [SUBCOMMAND]
  unisec size INPUT                               # All kinf of size information about a Unicode string
  unisec surrogates [SUBCOMMAND]
  unisec versions                                 # Version of anything related to Unicode as used in unisec
```

List sub-commands:

```
$ unisec surrogates --help
Commands:
  unisec surrogates from HIGH LOW                 # Code point ⬅️ Surrogates
  unisec surrogates to NAME                       # Code point ➡️ Surrogates
```

Sub-command help:

```
$ unisec surrogates from --help
Command:
  unisec surrogates from

Usage:
  unisec surrogates from HIGH LOW

Description:
  Code point ⬅️ Surrogates

Arguments:
  HIGH                              # REQUIRED High surrogate (in hexadecimal (0xXXXX), decimal (0dXXXX), binary (0bXXXX) or as text)
  LOW                               # REQUIRED Low surrogate (in hexadecimal (0xXXXX), decimal (0dXXXX), binary (0bXXXX) or as text)

Options:
  --help, -h                        # Print this help
```

### Examples

- **BiDi**
  - [Spoof](https://acceis.github.io/unisec/yard/Unisec/CLI/Commands/Bidi/Spoof)
- **Confusables**
  - [List](https://acceis.github.io/unisec/yard/Unisec/CLI/Commands/Confusables/List)
  - [Randomize](https://acceis.github.io/unisec/yard/Unisec/CLI/Commands/Confusables/Randomize)
- [Grep](https://acceis.github.io/unisec/yard/Unisec/CLI/Commands/Grep)
- [Hexdump](https://acceis.github.io/unisec/yard/Unisec/CLI/Commands/Hexdump)
- **Normalize**
  - [All](https://acceis.github.io/unisec/yard/Unisec/CLI/Commands/Normalize/All)
  - [Replace](https://acceis.github.io/unisec/yard/Unisec/CLI/Commands/Normalize/Replace)
- **Properties**
  - [Char](https://acceis.github.io/unisec/yard/Unisec/CLI/Commands/Properties/Char)
  - [Codepoints](https://acceis.github.io/unisec/yard/Unisec/CLI/Commands/Properties/Codepoints)
  - [List](https://acceis.github.io/unisec/yard/Unisec/CLI/Commands/Properties/List)
- [Size](https://acceis.github.io/unisec/yard/Unisec/CLI/Commands/Size)
- **Surrogates**
  - [From](https://acceis.github.io/unisec/yard/Unisec/CLI/Commands/Surrogates/From)
  - [To](https://acceis.github.io/unisec/yard/Unisec/CLI/Commands/Surrogates/To)
- [Versions](https://acceis.github.io/unisec/yard/Unisec/CLI/Commands/Versions)

[Library documentation for commands](https://acceis.github.io/unisec/yard/Unisec/CLI/Commands).

## Library

See examples in [the library documentation](https://acceis.github.io/unisec/yard/Unisec).

- [Unisec::Bidi](https://acceis.github.io/unisec/yard/Unisec/Bidi)
- [Unisec::Confusables](https://acceis.github.io/unisec/yard/Unisec/Confusables)
- [Unisec::Hexdump](https://acceis.github.io/unisec/yard/Unisec/Hexdump)
- [Unisec::Normalization](https://acceis.github.io/unisec/yard/Unisec/Normalization)
- [Unisec::Properties](https://acceis.github.io/unisec/yard/Unisec/Properties)
- [Unisec::Rugrep](https://acceis.github.io/unisec/yard/Unisec/Rugrep)
- [Unisec::Size](https://acceis.github.io/unisec/yard/Unisec/Size)
- [Unisec::Surrogates](https://acceis.github.io/unisec/yard/Unisec/Surrogates)
- [Unisec::Versions](https://acceis.github.io/unisec/yard/Unisec/Versions)
