_G.git_popup_win = nil

vim.api.nvim_create_user_command('GitPopup', function()
  vim.cmd 'Git'
  local git_buf = vim.api.nvim_get_current_buf()
  vim.cmd 'close'

  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local win = vim.api.nvim_open_win(git_buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })

  _G.git_popup_win = win

  -- Close status popup with <Esc>
  vim.api.nvim_buf_set_keymap(git_buf, 'n', '<Esc>', ':q<CR>', { noremap = true, silent = true })

  -- Override `cc` to open commit popup
  vim.api.nvim_buf_set_keymap(git_buf, 'n', 'cc', ':GitCommitPopup<CR>', { noremap = true, silent = true })
end, {})

-- Define custom command for commit popup
vim.api.nvim_create_user_command('GitCommitPopup', function()
  vim.cmd 'Git commit'

  vim.api.nvim_create_autocmd('BufReadPost', {
    pattern = 'COMMIT_EDITMSG',
    once = true,
    callback = function()
      local buf = vim.api.nvim_get_current_buf()

      -- Open commit message in floating window
      vim.cmd 'close'

      local width = math.floor(vim.o.columns * 0.6)
      local height = math.floor(vim.o.lines * 0.4)
      local row = math.floor((vim.o.lines - height) / 2)
      local col = math.floor((vim.o.columns - width) / 2)

      local win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = 'single',
      })

      _G.git_popup_win = win

      -- Add keybinds for commit and quit
      vim.api.nvim_buf_set_keymap(buf, 'n', '<leader>x', ':wq<CR>', { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', ':q<CR>', { noremap = true, silent = true })

      -- Auto-close the window after commit is saved
      vim.api.nvim_create_autocmd('BufWritePost', {
        buffer = buf,
        callback = function()
          vim.defer_fn(function()
            if _G.git_popup_win and vim.api.nvim_win_is_valid(_G.git_popup_win) then
              vim.api.nvim_win_close(_G.git_popup_win, true)
              _G.git_popup_win = nil
            end
          end, 100)
        end,
      })
    end,
  })
end, {})
