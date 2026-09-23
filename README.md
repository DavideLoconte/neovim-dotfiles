# Neovim Dotfiles

My personal Neovim configuration. It covers C/C++, Rust, Python, Java, Lua,
LaTeX and web development (HTML, CSS, JavaScript/TypeScript), and it runs on
Linux, macOS and Windows.

## Requirements

You'll need Neovim 0.12 or newer, plus a few tools that the config relies on:

- **fzf, fd and ripgrep** for the fzf-lua pickers
- **npm**, which mason uses to install the JavaScript-based language servers
- **cargo / rustup**, which provides `rustfmt` for Rust formatting
- **a JDK**, needed by `jdtls` for Java

Everything else depends on your operating system.

### Linux

- git, curl or wget, unzip, gzip and GNU tar
- `wl-clipboard` on Wayland, or `xclip`/`xsel` on X11, so yanking reaches the
  system clipboard
- `zathura` with `zathura-pdf-poppler` to view LaTeX output (see
  [LaTeX](#latex))

### macOS

- git, curl or wget, unzip, gzip and GNU tar (`brew install gnu-tar`)
- nothing extra for the clipboard: `pbcopy` and `pbpaste` ship with the system
- [Skim](https://skim-app.sourceforge.io) to view LaTeX output (see
  [LaTeX](#latex))

### Windows

- PowerShell, git, GNU tar, ripgrep and an archive tool such as 7-Zip
- [win32yank](https://github.com/equalsraf/win32yank) for the system clipboard
- [SumatraPDF](https://www.sumatrapdfreader.org) to view LaTeX output (see
  [LaTeX](#latex))

### Nice to have

- `bat` and `chafa` give fzf-lua richer previews
- a TeX distribution with `latexmk`, if you want to compile LaTeX

## Usage

The leader key is `Space`; the local leader (used by vimtex) is `,`.

| Key          | What it does                                             |
| ------------ | -------------------------------------------------------- |
| `<leader>pv` | Open the file explorer (mini.files) on the current file  |
| `<leader>ff` | Find files in the current file's directory               |
| `<leader>fg` | Find git-tracked files                                   |
| `<leader>fh` | Find files in your home directory                        |
| `<leader>gg` | Search file contents in the current file's directory     |
| `<leader>rh` | Search file contents in your home directory              |
| `<leader>fb` | Switch between open buffers                              |
| `<leader>fr` | Reopen the last picker where you left it                 |
| `<leader>h`  | Show the diagnostic under the cursor                     |
| `jj`         | Leave insert mode                                        |
| `Tab`        | Accept the Copilot suggestion, or pick the next completion |
| `Shift-Tab`  | Pick the previous completion                             |

A few things happen without pressing anything:

- completion suggestions pop up as you type, straight from the language server
- files are formatted every time you save
- brackets and quotes close themselves
- undo history survives closing a file
- yanks and pastes go through the system clipboard

To wrap text in brackets or quotes, use mini.surround: `sa` adds, `sd`
deletes and `sr` replaces. For example, `saiw"` puts quotes around the word
under the cursor, and `sr"'` swaps double quotes for single ones.

Language servers and formatters install themselves through mason the first
time Neovim starts; run `:Mason` to check on them.

GitHub Copilot suggestions show up as grey text while you type. The first
time, open any file and run `:LspCopilotSignIn` to log in with your GitHub
account.

## LaTeX

vimtex compiles documents with `latexmk` and opens the PDF in a viewer that
depends on your OS (the choice lives in `lua/DavideLoconte/compat.lua`). The
local leader is `,`: press `,ll` to start compiling and `,lv` to jump to the
current line in the PDF.

### Linux: zathura

```sh
sudo apt install zathura zathura-pdf-poppler   # or your distro's equivalent
```

vimtex talks to zathura directly, so there's nothing to configure. On X11,
installing `xdotool` lets vimtex bring the viewer window to the front.

### macOS: Skim

```sh
brew install --cask basictex skim   # or mactex for the full distribution
```

To jump from the PDF back to the source, open Skim's *Preferences → Sync*,
choose the **Custom** preset, set the command to `nvim` and the arguments to:

```
--headless -c "VimtexInverseSearch %line '%file'"
```

### Windows: SumatraPDF

Install [SumatraPDF](https://www.sumatrapdfreader.org) and add it to your
`PATH`. To jump from the PDF back to the source, go to *Settings → Options*
and set the inverse search command line to:

```
nvim --headless -c "VimtexInverseSearch %l '%f'"
```

## License

Released under the MIT License. The software is provided "as is", without
warranty of any kind. See the LICENSE file for details.
