# riscv.vim

RISC-V syntax highlighting for Vim.

This will override any other syntaxes for `.S` files.

## Installation

### Manually

Put all files in your vim directory (such as `~/.vim/` or `~/.config/nvim/`)

### VimPlug

1. Add the following to your `.vimrc`.

   ```vim
   Plug 'laurelmay/riscv.vim'
   ```
2. Install with `:PlugInstall`

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  'laurelmay/riscv.nvim',
  -- The ftdetect configuration does not work well when lazy-loaded
  lazy = false,
}
```

## Syntax Support

The syntax highlighting within this plugin is based on several sources.
Primarily, the latest versions of the [The RISC-V ISA Specification][spec],
and specifically [Volume I: Unprivileged ISA v. 201912123][vol1] and
[Volume II: Privileged Architecture v. 20211203][vol2]. Additionally, the
[RISC-V Assembly Programmer's Manual][riscv-asm] is used as a reference for
things not covered by the specification itself.

[spec]: https://riscv.org/technical/specifications/
[vol1]: https://github.com/riscv/riscv-isa-manual/releases/download/Ratified-IMAFDQC/riscv-spec-20191213.pdf
[vol2]: https://github.com/riscv/riscv-isa-manual/releases/download/Priv-v1.12/riscv-privileged-20211203.pdf
[riscv-asm]: https://github.com/riscv-non-isa/riscv-asm-manual/blob/master/riscv-asm.md

It is a goal to support any syntax that has been changed or renamed (such as
the `fmv.x.s` instruction) and syntax from drafts that may have real-world
usage, though support for these may not be as complete. Contributions to add
these are welcome.

Draft specifications implemented are based on:

- ["N" Extension](https://five-embeddev.com/riscv-isa-manual/latest/n.html#chap:n)
- ["V" Extension](https://github.com/riscv/riscv-v-spec/releases/tag/v1.0)

## Usage

Save your files with a .S extension or execute `set ft=riscv`.
