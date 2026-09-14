# NeoVim Dotfiles

Personal neovim configuration.

## Requirements

- Neovim: 0.12 or newer
- fzf, fd, ripgrep — used by the fzf-lua pickers
- npm — mason installs the JavaScript-based language servers with it
- cargo / rustup — provides `rustfmt`, used by conform on Rust files

Environment specific dependencies:

- Unix: git, curl or wget, unzip, gzip, and GNU tar
- Windows: PowerShell, git, GNU tar, ripgrep, and an archive tool (like 7zip)

### Optional

- bat, chafa — richer fzf-lua previews
- LaTeX: a TeX distribution providing `latexmk`, plus [Skim](https://skim-app.sourceforge.io)
  as the PDF viewer. See [LaTeX setup](#latex-setup).

## LaTeX setup

vimtex compiles with `latexmk` and previews in Skim:

```sh
brew install --cask basictex skim   # or mactex for the full distribution
```

Enable reverse search in Skim under *Preferences -> Sync*: set the preset to
**Custom**, the command to `nvim`, and the arguments to

```
--headless -c "VimtexInverseSearch %line '%file'"
```

The local leader is `,`, so `,ll` starts the compiler and `,lv` jumps to the
current line in Skim.

## License

This project is licensed under the MIT License. The software is provided "as
is", without warranty of any kind, and the authors are not liable for any
claims or damages. See the LICENSE file for full details.
