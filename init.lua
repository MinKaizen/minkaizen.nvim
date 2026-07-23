--[[
  Personal Neovim configuration, grown from kickstart.nvim.

  Layout (each module is loaded in order below):
    lua/custom/options.lua      editor options and globals
    lua/custom/keymaps.lua      keymaps and user commands
    lua/custom/autocmds.lua     autocommands
    lua/custom/godot.lua        Godot project detection and editor server
    lua/custom/git_popup.lua    floating lazygit-style git popup (:GitPopup)
    lua/custom/lazy.lua         lazy.nvim bootstrap and plugin setup
    lua/custom/plugins/*.lua    one plugin spec per file (auto-imported)
    lua/custom/snippets/*.lua   LuaSnip snippets (loaded by plugins/luasnip.lua)
    lua/kickstart/plugins/*.lua optional kickstart extras (enabled in lazy.lua)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'custom.options'
require 'custom.keymaps'
require 'custom.autocmds'
require 'custom.godot'
require 'custom.git_popup'
require 'custom.lazy'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
