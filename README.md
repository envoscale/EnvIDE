<img src="https://raw.githubusercontent.com/envoscale/.github/main/profile/assets/logo.svg" alt="" width="56" align="left">

# EnvIDE

A code editor and IDE written in [EnvoL](https://github.com/envoscale/EnvoLang), drawn
with [EnvoUI](https://github.com/envoscale/EnvoUI) and [EnvoR](https://github.com/envoscale/EnvoR):
no third-party code, and the same pixels on Windows and Linux.

<p align="center">
  <img src="docs/envide-dark.png" alt="EnvIDE in the dark theme: the EnvoLang repository in the sidebar with examples/02-shapes open, and its main.envol in the editor" width="100%">
</p>

<p align="center">
  <img src="docs/envide-light.png" alt="EnvIDE in the light theme, with examples/03-generics/main.envol open" width="100%">
</p>

Both pictures are EnvIDE drawing itself, without a window:

```bash
envide path/to/EnvoLang examples/02-shapes/main.envol --screenshot dark.ppm --size 1280x760
envide path/to/EnvoLang examples/03-generics/main.envol --screenshot light.ppm --light --size 1280x760
```

## What it does

- A sidebar with the folder's files: folders first, names in order, build output left
  out. Folders open and close; choosing a file opens it.
- The editor: syntax colors, line numbers, multiple cursors, selections and undo.
- A status bar with the file and the cursor's position, and a command palette
  (Ctrl+Shift+P).

Next: saving, then diagnostics, completion and go-to-definition through `envo lsp`, then
build, run, test and debug.

## Use

```bash
./build.sh run                         # build, then open EnvIDE on this folder
build/envide <folder> [file]           # open a folder, and a file in it
```

`./build.sh` clones EnvoLang at the commit in [`envolang.ref`](envolang.ref) and builds
it (about a minute, once); set `ENVOLANG` to use a checkout of your own. `./build.sh
test` runs the tests.

## Code

| File | |
|---|---|
| [`shell.envol`](shell.envol) | The window's parts and what input does to them. It never touches the window, so the tests drive it directly. |
| [`main.envol`](main.envol) | Arguments, then the window and its loop, or one frame into an image |
| [`tests/`](tests) | Tests, run by `envo test` |

Anything EnvIDE needs from the operating system is a port in the EnvoL library with
adapters there, never code here.

## License

Same as EnvoLang: see [LICENSE](LICENSE).
