# Dotfiles
---

## ![neovim-screenshot](https://github.com/user-attachments/assets/3e95040e-9ba0-4373-a54a-a16ae1f0adb5)

![i3-screenshot](https://github.com/user-attachments/assets/1b48399a-96d8-4b00-97a3-5da5171494c7)

## Prerequisites (Neovim):
- Neovim 0.11+
- A nerd font (recommended: JetBrains Mono Nerd, available here: https://www.nerdfonts.com/#features)
- `sudo apt install git gcc python3 python3-pip python3-venv jupyter-client librsvg2-bin fd-find python3-pynvim jupyter-client`
- [tex-fmt](https://github.com/WGUNDERWOOD/tex-fmt/releases)
- [python-type-stubs](https://github.com/microsoft/python-type-stubs)

## Mappings etc.

`<leader>` = spacebar

### Completion:
`<C-p>` previous, `<C-n>` next, `<C-y>` accept

### Search mappings:
- `<leader>sf` search files
- `<leader>sg` search grep (find text inside files)
- `<leader>sw` search for word under cursor

### Comments
`gc<movement>` - toggle comment
- `gcc` toggle comment one line
- in visual `gc` comment selection
- `gc<Down` comment this line and the line below

### LSP: errors/linting
- `<leader>e` expand diagnostic under cursor
- `<leader>ca` execute code action under cursor (e.g. when "fix available")
- `]d`, `[d` next/previous diagnostic

### Python notebook-like execution
- in visual `<leader>r` - evaluate selection
- `<leader>rr` over an evaluated cell - reevaluate cell
