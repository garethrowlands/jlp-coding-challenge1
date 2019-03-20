# jlp-coding-challenge1

## Install toolchain

https://docs.haskellstack.org/en/stable/README/#how-to-install

## Building

```
stack build
```

## Testing

```
stack test
```

## Running

```
$ stack exec jlp-coding-challenge1 20
20 seconds
```

## How it works

* Toolchain is `stack`
* Compiler is `GHC 8.6.4`
* Code under test are in `src/FormatTime.hs`
* Tests are in `test/FormatTimeSpec.hs`
* There's a main program in `app/Main.hs`

The algorithm is known as an unfold. An unfold creates a list or other structure from a seed by repeatedly applying a step function.

Each step finds the largest time period that exceeds the given number of seconds. For example, "hour" for 3600. It also finds the remaining seconds. For example, 2 for 62.

See `FormatTimeSpec.hs` for more.
