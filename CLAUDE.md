# CLAUDE.md

Personal Neovim configuration based on kickstart.nvim. Entry point is `init.lua`, which loads modules from `lua/custom/` in order; every plugin spec lives in its own file under `lua/custom/plugins/` (auto-imported by lazy.nvim). See the README for the full layout.

- Formatting: stylua, config in `.stylua.toml`. Run `stylua .` (mason installs it to `~/.local/share/nvim/mason/bin/`).
- Sanity check after config changes: `nvim --headless -c 'lua vim.print("CONFIG_OK")' -c 'qa!'` should print `CONFIG_OK` with no errors.

## Kaizen

This project runs the kaizen loop (`.kaizen/`). When the user says "continue", "go again", or that they left comments/reviews, invoke the `kaizen` skill (or read its SKILL.md and follow it) - harvest the `kaizen::` lines and `kaizen` comment files and run the cycle. Read `.kaizen/instructions.md` and `.kaizen/taste.md` before writing or judging any artifact in this project, always.

Note: `.kaizen/` is gitignored in this repo (the human's choice), so harvesting must use plain `grep -rn` over `.kaizen/` in addition to `git grep` over the tree.
