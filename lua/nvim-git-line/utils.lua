--[[ Copyright © 2022 Ryan Ciehanski ]]
--[[ MIT license, see LICENSE for more details. ]]

local M = {}
local api = vim.api
local fn = vim.fn

function M.open_url(url)
  -- Open URL in default browser
  local vim_os = vim.loop.os_uname().sysname
  if vim_os == "Windows" then
    -- Windows
    os.execute('start "" "' .. url .. '"')
  else
    -- All other OS'
    os.execute('open "" "' .. url .. '"')
  end
end

function M.get_git_branch_name()
  local branch = ""
  if fn.system("git rev-parse --is-inside-work-tree | tr -d '\n'") == "true" then
    branch = fn.system("git branch --show-current | tr -d '\n'")
    local blen = branch:len()
    if blen ~= 0 then
      if (blen - 1) == "%" then
        branch = branch:sub(0, (blen - 1))
      end
    end
  end
  return branch
end

function M.get_remote_repo_name()
  local remote_origin = fn.system("git remote get-url origin")
  local repo_git = remote_origin:sub(remote_origin:find("/[^/]*$") + 1)
  local repo_name = ""
  for v in string.gmatch(repo_git, "[^.]+") do
    repo_name = v
    break
  end
  return repo_name
end

function M.get_remote_username()
  local remote_origin = fn.system("git remote get-url origin")
  local username_git = remote_origin:sub(remote_origin:find("/[^/]+/[^/]*$") + 1)
  local username = username_git:match("^[^/]+")
  return username
end

function M.get_buffer_name()
  -- Get buffer name from bufnr
  local bufname = fn.expand("%:t")
  -- Ship it
  return bufname
end

return M
