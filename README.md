# Application Reader Linux

A simple library for ewwii which makes building docks easier! With this library, you can read, parse, and list applications that has a `.desktop` file.

## Installation

Just run the following command and you will have the library installed in `~/.eiipm/lib/app-reader-lin/`.

```bash
$ eiipm i app-reader-lin
```

## Usage example

```js
import "~/.eiipm/lib/app-reader-lin/app-reader-lin.rhai" as apprl;

// prints an array of applications found
print(apprl::list_apps());
```
