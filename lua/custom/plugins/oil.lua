return {
  'stevearc/oil.nvim',
  opts = {
    default_file_explorer = true,
  },
  keys = {
    { '-', '<cmd>Oil<cr>', desc = 'Open parent directory', mode = 'n' },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
