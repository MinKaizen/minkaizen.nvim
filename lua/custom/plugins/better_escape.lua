return {
  'max397574/better-escape.nvim',
  config = function()
    require('better_escape').setup {
      -- Only enable in insert mode, not visual mode
      default_mappings = true,
      mappings = {
        i = {
          j = {
            k = '<Esc>',
            j = '<Esc>',
          },
        },
        v = {}, -- Disable all mappings in visual mode
      },
    }
  end,
}
