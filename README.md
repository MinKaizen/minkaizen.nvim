# nvim config

Personal Neovim configuration, originally based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) and since split into modules. Plugins are managed with [lazy.nvim](https://github.com/folke/lazy.nvim).

## Requirements

- Neovim 0.12+ (this config uses the `main` branch of nvim-treesitter, which requires it)
- `git`, `make`, `unzip`, a C compiler (`gcc`/`clang`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation) for Telescope live grep
- The [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter), required by nvim-treesitter's `main` branch to install parsers. Install it via Mason (`:MasonInstall tree-sitter-cli`) or your system package manager
- A clipboard tool (`pbcopy` on macOS, xclip/xsel/win32yank elsewhere)
- A [Nerd Font](https://www.nerdfonts.com/), assumed by `vim.g.have_nerd_font = true` in `lua/custom/options.lua`
- Language-specific tools as needed (e.g. `npm` for TypeScript, `go` for Golang)

## Installation

Clone into your Neovim config directory and start `nvim`; lazy.nvim bootstraps itself and installs everything on first run (`:Lazy` to check status).

```sh
git clone <this-repo> "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
nvim
```

`lazy-lock.json` is tracked so plugin versions are reproducible.

## Structure

```
init.lua                     entry point: sets the leader key, then loads the modules below in order
lua/custom/
  options.lua                editor options and globals
  keymaps.lua                keymaps and user commands (BdeleteAll, BdeleteOthers, DapCloseAll)
  autocmds.lua               autocommands (yank highlight, blade filetype, oil on directory open)
  godot.lua                  Godot project detection and editor server socket
  git_popup.lua              floating git popup (:GitPopup)
  lazy.lua                   lazy.nvim bootstrap and setup (the single plugin registry)
  plugins/                   one lazy.nvim spec per file, auto-imported
  snippets/                  LuaSnip snippets, loaded by plugins/luasnip.lua
lua/kickstart/
  health.lua                 :checkhealth support
  plugins/                   optional kickstart extras, enabled explicitly in lua/custom/lazy.lua
doc/                         vim help doc for the original kickstart notes
```

### Adding a plugin

Create a new file in `lua/custom/plugins/` that returns a [lazy.nvim spec](https://lazy.folke.io/spec) - it is picked up automatically. Kickstart extras under `lua/kickstart/plugins/` are opted in/out via the `require` lines in `lua/custom/lazy.lua`.

### Conventions

- Formatting: [stylua](https://github.com/JohnnyMorganz/StyLua), config in `.stylua.toml` (single quotes, 2-space indent). Mason installs the binary to `~/.local/share/nvim/mason/bin/`.
- Sanity check after changes: `nvim --headless -c 'lua vim.print("CONFIG_OK")' -c 'qa!'` should print `CONFIG_OK` with no errors.

## FAQ

- Run this config in parallel with another one using [NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME), e.g. `NVIM_APPNAME=nvim-test nvim` with the config in `~/.config/nvim-test`.
- To start fresh, remove `~/.local/share/nvim/` and `~/.local/state/nvim/` along with this directory.
