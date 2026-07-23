-- Autoformat (manual only via <leader>f; format on save is intentionally disabled)
return {
  'stevearc/conform.nvim',
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    formatters = {
      pint = {
        command = './vendor/bin/pint',
        args = { '$FILENAME' },
        stdin = false,
        condition = function()
          return vim.fn.filereadable './vendor/bin/pint' == 1
        end,
      },
      liquid = {
        command = 'prettierd',
        args = { '$FILENAME' },
      },
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      php = { 'pint' },
      liquid = { 'liquid' },
      blade = { 'blade-formatter' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  },
}
