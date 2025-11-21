return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      direction = 'float',
      float_opts = {
        border = 'rounded',
        width = math.floor(vim.o.columns * 0.8),
        height = math.floor(vim.o.lines * 0.8),
      },
    }

    vim.keymap.set('n', '<leader>t', ':ToggleTerm<CR>')
  end,
}
