-- [[ Godot project detection ]]
-- When the cwd (or its parent) is a Godot project, start a server socket so
-- Godot's external editor integration can open files in this Neovim instance.

-- paths to check for project.godot file
local paths_to_check = { '/', '/../' }
_G.is_godot_project = false
_G.godot_project_path = ''
local cwd = vim.fn.getcwd()

-- iterate over paths and check
for _, value in pairs(paths_to_check) do
  if vim.uv.fs_stat(cwd .. value .. 'project.godot') then
    is_godot_project = true
    godot_project_path = cwd .. value
    break
  end
end

-- check if server is already running in godot project path
local is_server_running = vim.uv.fs_stat(godot_project_path .. '/.godothost')
-- start server, if not already running
if is_godot_project and not is_server_running then
  print 'Godot serve should be running'
  vim.fn.serverstart(godot_project_path .. '/.godothost')
end
