return {
  'ellisonleao/dotenv.nvim',
  lazy = false,
  priority = 999,
  config = function()
    local dotenv = require 'dotenv'
    dotenv.setup {
      enable_on_load = true,
    }
  end,
}
