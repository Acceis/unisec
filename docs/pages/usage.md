# Usage

## CLI

### General help

List commands:

```
$ unisec --help
Commands:
  unisec confusables [SUBCOMMAND]
  unisec hexdump INPUT                            # Hexdump in all Unicode encodings
  unisec properties [SUBCOMMAND]
  unisec surrogates [SUBCOMMAND]
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

- **Confusables**
  - [List](https://acceis.github.io/unisec/yard/Unisec/CLI/Commands/Confusables/List)
  - [Randomize](https://acceis.github.io/unisec/yard/Unisec/CLI/Commands/Confusables/Randomize)
- [Hexdump](https://acceis.github.io/unisec/yard/Unisec/CLI/Commands/Hexdump)
- **Properties**
  - [Char](https://acceis.github.io/unisec/yard/Unisec/CLI/Commands/Properties/Char)
  - [Codepoints](https://acceis.github.io/unisec/yard/Unisec/CLI/Commands/Properties/Codepoints)
  - [List](https://acceis.github.io/unisec/yard/Unisec/CLI/Commands/Properties/List)
- **Surrogates**
  - [From](https://acceis.github.io/unisec/yard/Unisec/CLI/Commands/Surrogates/From)
  - [To](https://acceis.github.io/unisec/yard/Unisec/CLI/Commands/Surrogates/To)

[Library documentation for commands](https://acceis.github.io/unisec/yard/Unisec/CLI/Commands).

## Library

See examples in [the library documentation](https://acceis.github.io/unisec/yard/Unisec).

- [Unisec::Confusables](https://acceis.github.io/unisec/yard/Unisec/Confusables)
- [Unisec::Hexdump](https://acceis.github.io/unisec/yard/Unisec/Hexdump)
- [Unisec::Properties](https://acceis.github.io/unisec/yard/Unisec/Properties)
- [Unisec::Surrogates](https://acceis.github.io/unisec/yard/Unisec/Surrogates)
