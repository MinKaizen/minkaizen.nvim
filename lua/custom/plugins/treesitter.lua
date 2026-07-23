-- Highlight, edit, and navigate code
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main', -- rewritten API; the old master branch is archived and frozen
  lazy = false, -- the main branch does not support lazy-loading
  build = ':TSUpdate',
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  config = function()
    -- The main branch has no `ensure_installed`; install() is async and
    -- skips parsers that are already installed.
    require('nvim-treesitter').install {
      'bash',
      'blade',
      'c',
      'css',
      'diff',
      'elixir',
      'erlang',
      'gdscript',
      'gdshader',
      'godot_resource',
      'html',
      'javascript',
      'liquid',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'php',
      'python',
      'query',
      'sql',
      'svelte',
      'toml',
      'typescript',
      'vim',
      'vimdoc',
      'yaml',
    }

    -- Highlighting and indentation are opt-in per buffer on the main branch
    local no_ts_indent = { gdscript = true, gdshader = true, godot_resource = true, ruby = true }
    vim.api.nvim_create_autocmd('FileType', {
      desc = 'Enable treesitter highlighting and indentation',
      group = vim.api.nvim_create_augroup('treesitter-start', { clear = true }),
      callback = function(args)
        -- Filetypes without an installed parser keep regex highlighting
        if not pcall(vim.treesitter.start, args.buf) then
          return
        end
        if not no_ts_indent[vim.bo[args.buf].filetype] then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
