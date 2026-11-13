# Envo Studio

A code editor and IDE written in [Envo](https://github.com/envoscale/EnvoScale), on Envo's
own standard library: no third-party code, and the same program on Windows, Linux and
(later) in the browser.

![Envo Studio](docs/studio.png)

**Where it is:** the shell. A sidebar with the folder's files, tabs, the code editor with
syntax colors, a status bar with the cursor's position, and a command palette
(Ctrl+Shift+P). Next: opening and saving files, then diagnostics, completion and
go-to-definition through `envo lsp`, then build, run, test and debug.

## Build

```bash
./build.sh run
```

This clones EnvoScale at the commit in [`envoscale.ref`](envoscale.ref), builds it (about
a minute, once), then builds and opens Studio. `./build.sh test` runs the tests. To use an
EnvoScale checkout you are working on, set `ENVOSCALE` to its folder.

## Code

| File | |
|---|---|
| [`shell.envo`](shell.envo) | The window's parts and what input does to them. It never touches the window, so the tests drive it directly. |
| [`main.envo`](main.envo) | Opens the window and runs the loop |
| [`tests/`](tests) | Tests, run by `envo test` |

Anything Studio needs from the operating system is a port in EnvoScale's library with
adapters there, never code here.

## License

Same as EnvoScale: see [LICENSE](LICENSE).
