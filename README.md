# Brutus #

An implementation of a brute force attack against Caesar's cipher in Haskell, for my college Information Security class.

## Installation ##

You need to have the [Haskell Platform](https://www.haskell.org/platform/ "Download Haskell") installed. After that, clone this repository and make the binary:

```bash
$ git clone git@github.com:aaditmshah/brutus.git
$ cd brutus
$ ghc --make brutus.hs -o brutus
```

If you don't have `git` then you can simply download the [repository archive](https://github.com/aaditmshah/brutus/archive/master.zip) and unzip it.

## Usage ##

After you have made the binary you can use it as follows:

```bash
$ ./brutus
Usage: brutus alphabetic|alphanumeric|ascii
$ ./brutus alphabetic
TI IJ, QGJIt? iwtC upAA, RptHpG!
Et tu, Brute? Then fall, Caesar!
```

Use the `j` and `f` keys to cycle forward and backward through the solutions, respectively. Send an end-of-transmission character to return to the prompt.

The binary takes a single argument: an alphabet. The alphabet must be one of the following:

1. `alphabetic`: uppercase and lowercase latin alphabets (i.e. `[A-Za-z]`).
2. `alphanumeric`: digits plus `alphabetic` characters (i.e. `[0-9A-Za-z]`).
3. `ascii`: punctuators plus `alphanumeric` characters (i.e. `[!-~]`).

Characters not in the given alphabet are copied to the output verbatim.

## License ##

Since this is my college work, and since my class mates have plagiarized my work before, I have decided to take action against it:

```
Copyright (c) 2014 Aadit M Shah <aaditmshah@fastmail.fm>

Everyone is permitted to use, copy and modify this software. However distribution of the software, verbatim or modified, is not permitted without the author's non-repudiatable consent.
```