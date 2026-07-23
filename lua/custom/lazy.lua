-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  Run `:Lazy` to check plugin status and `:Lazy update` to update plugins.
--
--  Plugin specs live in `lua/custom/plugins/*.lua` - one file per plugin,
--  auto-imported below via `{ import = 'custom.plugins' }`. To add a plugin,
--  drop a new file there that returns a lazy.nvim spec.
--
--  `lua/kickstart/plugins/*.lua` holds optional kickstart extras that are
--  enabled explicitly here; uncomment a `require` line to turn one on.
require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'tpope/vim-speeddating', -- Increment/decrement dates with <C-a>/<C-x>

  -- Kickstart extras
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.neo-tree',
  -- NOTE: the active gitsigns config lives in `lua/custom/plugins/gitsigns.lua`;
  -- `kickstart.plugins.gitsigns` is the unused upstream variant.

  -- All other plugins: one spec file each under `lua/custom/plugins/`
  { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
