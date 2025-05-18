vim.api.nvim_create_user_command('GitPopup', function()
  -- Run :Git to get the fugitive status buffer name
  vim.cmd 'Git'

  -- Get the buffer number of the fugitive buffer
  local git_buf = vim.api.nvim_get_current_buf()

  -- Close the window Fugitive opened
  vim.cmd 'close'

  -- Calculate dimensions for the floating window
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Open a new floating window with the fugitive buffer
  vim.api.nvim_open_win(git_buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })

  -- Optional: close the popup with <Esc>
  vim.api.nvim_buf_set_keymap(git_buf, 'n', '<Esc>', '<cmd>close<CR>', { noremap = true, silent = true })
end, {})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'gitcommit',
  callback = function()
    local buf = vim.api.nvim_get_current_buf()

    -- Close the window that Fugitive created
    vim.cmd 'close'

    -- Floating window dimensions
    local width = math.floor(vim.o.columns * 0.6)
    local height = math.floor(vim.o.lines * 0.4)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    -- Open commit buffer in a floating window
    vim.api.nvim_open_win(buf, true, {
      relative = 'editor',
      width = width,
      height = height,
      row = row,
      col = col,
      style = 'minimal',
      border = 'single',
    })

    -- Map <Esc> to close the commit window
    vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', ':q<CR>', { noremap = true, silent = true })
  end,
})

-- Auto-close the floating window after committing (on write)
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = 'COMMIT_EDITMSG',
  callback = function()
    vim.defer_fn(function()
      if _G.git_popup_win and vim.api.nvim_win_is_valid(_G.git_popup_win) then
        vim.api.nvim_win_close(_G.git_popup_win, true)
        _G.git_popup_win = nil
      end
    end, 100) -- give git time to write output before closing
  end,
})
