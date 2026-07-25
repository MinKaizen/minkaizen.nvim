return {
  'stevearc/oil.nvim',
  opts = {
    default_file_explorer = true,
    keymaps = {
      -- Open file under cursor with the OS default app (images, PDFs, etc.)
      -- Uses vim.ui.open / open / xdg-open / rundll32 — OS-agnostic
      ['gx'] = 'actions.open_external',
    },
  },
  keys = {
    { '-', '<cmd>Oil<cr>', desc = 'Open parent directory', mode = 'n' },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
