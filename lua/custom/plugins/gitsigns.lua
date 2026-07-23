-- Adds git related signs to the gutter, as well as utilities for managing changes
-- See `:help gitsigns` to understand what the configuration keys do
return {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, lhs, rhs, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- Alt-j/k for next/prev hunk
        map('n', '<A-j>', gs.next_hunk, { desc = 'Next Hunk' })
        map('n', '<A-k>', gs.prev_hunk, { desc = 'Prev Hunk' })

        -- Select current hunk
        map('n', '<leader>hv', gs.select_hunk, { desc = 'Select Hunk' })
        map('x', '<leader>hv', function()
          gs.select_hunk()
        end, { desc = 'Select Hunk' })

        -- Stage selected hunk
        map('n', '<leader>hs', gs.stage_hunk, { desc = 'Stage Hunk' })

        -- Unstage selected hunk
        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Unstage Hunk' })

        -- Revert selected hunk
        map('n', '<leader>hr', gs.reset_hunk, { desc = 'Revert Hunk' })
      end,
    }
  end,
}
