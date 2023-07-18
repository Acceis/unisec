# Usage

## CLI

List commands:

```
$ unisec --help
Commands:
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

Also find CLI examples in [the library documentation](https://acceis.github.io/unisec/yard/Unisec/CLI/Commands), e.g. [surrogates](https://acceis.github.io/unisec/yard/Unisec/CLI/Commands/Surrogates/From).

## Library

See examples in [the library documentation](https://acceis.github.io/unisec/yard/Unisec), e.g. [surrogates](https://acceis.github.io/unisec/yard/Unisec/Surrogates).
