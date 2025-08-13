return {
  'ellisonleao/dotenv.nvim',
  lazy = false,
  priority = 999,
  config = function()
    require('dotenv').setup()
  end,
}
