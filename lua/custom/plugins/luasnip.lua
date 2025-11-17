return {
  'L3MON4D3/LuaSnip',
  version = '2.*',
  build = (function()
    -- Build Step is needed for regex support in snippets.
    -- This step is not supported in many windows environments.
    -- Remove the below condition to re-enable on windows.
    if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
      return
    end
    return 'make install_jsregexp'
  end)(),
  dependencies = {
    -- `friendly-snippets` contains a variety of premade snippets.
    --    See the README about individual language/framework/plugin snippets:
    --    https://github.com/rafamadriz/friendly-snippets
    -- {
    --   'rafamadriz/friendly-snippets',
    --   config = function()
    --     require('luasnip.loaders.from_vscode').lazy_load()
    --   end,
    -- },
  },
  opts = {},
  config = function()
    local ls = require 'luasnip'
    local types = require 'luasnip.util.types'

    ls.config.set_config {
      enable_autosnippets = true,
      history = true,
      updateevents = 'TextChanged,TextChangedI',
      extopts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { '←', 'Error' } },
          },
        },
      },
    }
    -- Load your custom snippets
    require('luasnip.loaders.from_lua').lazy_load { paths = { '~/.config/nvim/lua/custom/snippets' } }

    vim.keymap.set('n', '<leader>ls', function()
      ls.cleanup() -- remove existing snippets
      require('luasnip.loaders.from_lua').lazy_load { paths = { '~/.config/nvim/lua/custom/snippets' } }
      print 'Snippets reloaded!'
    end, { desc = 'Reload LuaSnip snippets' })

    vim.keymap.set({ 'i', 's' }, '<Tab>', function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, { silent = true })

    vim.keymap.set({ 'i', 's' }, '<S-Tab>', function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, { silent = true })
  end,
}
