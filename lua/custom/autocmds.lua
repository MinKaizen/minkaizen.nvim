-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Set filetype for Blade templates
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  desc = 'Set filetype for Blade templates',
  pattern = '*.blade.php',
  callback = function()
    vim.bo.filetype = 'blade'
  end,
})

-- Set oil to always open no matter what
-- (VimEnter fires after startup completes, so plugins are available here)
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    local arg = vim.fn.argv()[1]
    if arg and vim.fn.isdirectory(arg) == 1 then
      require('oil').open(arg) -- open oil in that directory
    end
  end,
})
