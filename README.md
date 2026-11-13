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

- **Files:** New, Open File, Open Folder, Save, Save As, Save All, Revert, Close. A tab
  with unsaved changes has a dot, and so does the window's title; EnvIDE asks before
  closing it or quitting. Unsaved changes are copied to a backup every few seconds and
  when the window closes, and the next start in the same folder brings them back.
- **Tabs:** many files open at once, each with its own cursor and undo history; Ctrl+Tab
  and Ctrl+Shift+Tab move between them.
- **Menus:** File, Edit, View, Go and Help, with every shortcut shown, and a command
  palette (Ctrl+Shift+P) that lists every command.
- **Finding things:** Go to File (Ctrl+P) over the whole folder, Go to Line (Ctrl+G),
  Find (Ctrl+F, then F3) and Replace (Ctrl+H).
- **The sidebar:** the folder's files with icons by kind (the EnvoL mark for `.envol`,
  `.envon` and `.eir`), folders first, build output left out. Ctrl+B hides it; its edge
  drags.
- **The editor:** syntax colors, line numbers, multiple cursors, toggle comment (Ctrl+/),
  zoom (Ctrl+= and Ctrl+-), a light or dark theme.
- **Files it should not open:** images, executables and other binary files are described
  instead, and files over 64 MB are refused. Text with bytes that are not UTF-8 opens,
  and EnvIDE asks before saving it.

What comes next is in the [roadmap](https://github.com/envoscale/EnvoScale/blob/main/envide/roadmap.md):
completion and diagnostics through `envo lsp`, panels and split editors, a terminal,
build, run and debug, and plugins.

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

Apache-2.0: see [LICENSE](LICENSE) and [NOTICE](NOTICE).
