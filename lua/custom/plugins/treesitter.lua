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
      'json',
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
        -- Keep regex highlighting unless both a parser and highlight query exist.
        -- vim.treesitter.start() disables regex syntax even when no query is found.
        local has_parser, parser = pcall(vim.treesitter.get_parser, args.buf)
        if not has_parser or parser == nil then
          return
        end

        local has_query, query = pcall(vim.treesitter.query.get, parser:lang(), 'highlights')
        if not has_query or query == nil then
          return
        end

        vim.treesitter.start(args.buf)
        if not no_ts_indent[vim.bo[args.buf].filetype] then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
