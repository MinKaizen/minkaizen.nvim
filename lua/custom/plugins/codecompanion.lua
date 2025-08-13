return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'ellisonleao/dotenv.nvim',
  },
  config = function()
    -- helper to get a real string from env
    local function getenv(name)
      local v = vim.fn.getenv(name)
      if v == vim.NIL then
        return nil
      end
      if type(v) ~= 'string' then
        return nil
      end
      if v == '' then
        return nil
      end
      return v
    end

    require('codecompanion').setup {
      strategies = {
        chat = { adapter = 'openai' },
        inline = { adapter = 'openai' },
        cmd = { adapter = 'openai' },
      },
      adapters = {
        openai = function()
          -- Prefer a scoped var, fall back to common name
          local key = getenv 'OPENAI_KEY_CODECOMPANION' or getenv 'OPENAI_API_KEY'
          assert(key, '[codecompanion] Missing OPENAI_* API key in environment (.env)')

          -- IMPORTANT: ensure we’re calling the chat/completions endpoint (expects `choices`)
          return require('codecompanion.adapters').extend('openai', {
            env = { api_key = key },
            schema = { url = 'https://api.openai.com/v1/chat/completions' },
            model = 'gpt-4o-mini', -- or your preferred OpenAI chat model
          })
        end,
      },
    }
  end,
}
