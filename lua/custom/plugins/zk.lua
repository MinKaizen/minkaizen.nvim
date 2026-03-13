-- Define the function, but DO NOT call it yet
local config_func = function()
  local notebook_dir = os.getenv("ZK_NOTEBOOK_DIR")

  if not notebook_dir then
    vim.notify(
      "ZK_NOTEBOOK_DIR is not set! zk-nvim is falling back to the current directory.",
      vim.log.levels.WARN,
      { title = "Zk-Nvim Configuration" }
    )
    notebook_dir = vim.fn.getcwd()
  end

  require("zk").setup({
    notebook_path = notebook_dir,
    picker = "telescope",
    lsp = {
      config = {
        cmd = { "zk", "lsp" },
        name = "zk",
      },
      auto_attach = {
        enabled = true,
        filetypes = { "markdown" },
      },
    },
  })
end

-- Return the TABLE lazy expects. 
-- Note that we pass the function to the 'config' key WITHOUT ()
return {
  "zk-org/zk-nvim",
  config = config_func
}
