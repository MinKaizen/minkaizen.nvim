-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Use visual lines when navigating
vim.keymap.set({ 'n', 'v' }, 'j', 'gj', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, 'k', 'gk', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '0', 'g0', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '$', 'g$', { noremap = true, silent = true })

-- Jump to previous/next bracket without clobbering the search register
vim.keymap.set('n', '(', function()
  vim.fn.search([=[[\[{(]]=], 'b')
end, { desc = 'Jump to previous bracket' })
vim.keymap.set('n', ')', function()
  vim.fn.search [=[[\]})]]=]
end, { desc = 'Jump to next bracket' })

-- [[ Custom keybinds and remaps ]]
-- Double tap v to enter visual line mode
vim.keymap.set('n', 'vv', 'V', { desc = 'Visual Line Mode' })

-- Keep cursor in the middle of the screen when navigating
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
-- Keep the copied text when pasting over in visual mode (see :h v_P)
vim.keymap.set('x', 'p', 'P')
-- Disable capital Q
vim.keymap.set('n', 'Q', '<nop>')
-- Disable singular s
vim.keymap.set('n', 's', '<nop>')
-- Jump to start/end of line with H/L
vim.keymap.set('n', 'H', '^')
vim.keymap.set('v', 'H', '^')
vim.keymap.set('o', 'H', '^')
vim.keymap.set('n', 'L', '$')
vim.keymap.set('v', 'L', '$')
vim.keymap.set('o', 'L', '$')

-- Git
vim.keymap.set('n', '<leader>gs', ':GitPopup<CR>')
vim.keymap.set('n', '<leader>gc', ':G commit<CR>')

-- Buffer stuff
vim.keymap.set('', '<leader>bd', function()
  require('mini.bufremove').delete(0, false)
end, { desc = 'Delete buffer safely' })

-- Ctrl+w -> f to focus the floating window
vim.keymap.set('n', '<C-w>f', function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative ~= '' then
      vim.api.nvim_set_current_win(win)
      break
    end
  end
end, { desc = 'Focus floating window' })

-- [[ User commands ]]

-- Use mini.bufremove to delete all buffers
vim.api.nvim_create_user_command('BdeleteAll', function()
  local bufs = vim.api.nvim_list_bufs()
  for _, buf in ipairs(bufs) do
    if vim.api.nvim_buf_is_loaded(buf) then
      require('mini.bufremove').delete(buf, false)
    end
  end
end, {})
vim.keymap.set('n', '<leader>bq', '<cmd>BdeleteAll<CR>', { desc = 'Close all buffers' })

-- Use mini.bufremove to delete all but the current buffer
vim.api.nvim_create_user_command('BdeleteOthers', function()
  local current = vim.api.nvim_get_current_buf()
  local bufs = vim.api.nvim_list_bufs()
  for _, buf in ipairs(bufs) do
    if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
      require('mini.bufremove').delete(buf, false)
    end
  end
end, {})
vim.keymap.set('n', '<leader>bs', '<cmd>BdeleteOthers<CR>', { desc = 'Close other buffers' })

-- Close every window showing a DAP buffer
vim.api.nvim_create_user_command('DapCloseAll', function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local bufname = vim.api.nvim_buf_get_name(buf)
    if bufname:match 'dap%-repl' or bufname:match 'DAP' then
      vim.api.nvim_win_close(win, true)
    end
  end
end, {})
