--[[ Copyright © 2022 Ryan Ciehanski <ryan@ciehanski.com> ]]
--[[ MIT license, see LICENSE for more details. ]]

local M = {}

local api = vim.api
local fn = vim.fn

-- @param url string
function M.open_url(url)
  -- Open URL in default browser
  local vim_os = vim.loop.os_uname().sysname
  if vim_os == "Windows" or vim_os == "Windows_NT" then
    -- Windows
    os.execute('start "" "' .. url .. '"')
  elseif vim_os == "Darwin" then
    -- macOS
    os.execute('open "' .. url .. '"')
  else
    -- Linux
    os.execute('xdg-open "' .. url .. '"')
  end
end

-- @return string
function M.get_branch_name()
  local branch = ""
  if M.is_git_dir() then
    branch = fn.system("git branch --show-current | tr -d '\n'")
    local blen = branch:len()
    if blen ~= 0 then
      if branch:sub(-1) == "%" then
        branch = branch:sub(0, (blen - 2))
      end
    end
  end
  return branch
end

-- @return string
function M.get_remote_repo_name()
  local repo_name = ""
  if M.is_git_dir() then
    local remote_origin = fn.system("git remote get-url origin | tr -d '\n'")
    local repo_git = remote_origin:sub(remote_origin:find("/[^/]*$") + 1)
    local dot_index, _ = repo_git:find(".", 1, true)
    repo_name = repo_git:sub(0, dot_index - 1)
  end
  return repo_name
end

-- @return string
function M.get_remote_username()
  local username = ""
  if M.is_git_dir() then
    local remote_origin = fn.system("git remote get-url origin | tr -d '\n'")

    local user_repo
    if remote_origin:find("http") then
      -- http(s)
      user_repo = remote_origin:match("[^/]+/[^/]*$")
    else
      -- ssh
      user_repo = remote_origin:match("[:/]([^:/]+/[^/]+)$")
    end

    username = user_repo:match("^[^/]+")
  end
  return username
end

-- @param repo_name string
-- @return string
function M.get_buffer_name(repo_name)
  -- Get buffer name from bufnr
  local bufpath = fn.expand("%:p")
  local _, eindex = bufpath:find(repo_name, 1, true)
  local bufname = bufpath:sub(eindex + 2)
  -- Ship it
  return bufname
end

-- @return string
function M.get_line_number()
  return vim.inspect(api.nvim_win_get_cursor(0)[1])
end

-- @return boolean
function M.is_git_dir()
  if fn.system("git rev-parse --is-inside-work-tree | tr -d '\n'") == "true" then
    return true
  else
    vim.pretty_print("nvim-git-line: Unable to process, not in a working git repository.")
    return false
  end
end

return M
