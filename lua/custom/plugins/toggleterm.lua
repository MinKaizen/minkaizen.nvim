return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      direction = 'float',
      float_opts = {
        border = 'rounded',
        -- Functions so the float adapts when the terminal window is resized
        width = function()
          return math.floor(vim.o.columns * 0.8)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.8)
        end,
      },
    }

    -- <leader>tt (not <leader>t) so it doesn't shadow the [T]oggle group (<leader>th etc.)
    vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm<CR>', { desc = '[T]oggle [T]erminal' })
  end,
}
