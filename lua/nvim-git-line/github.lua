--[[ Copyright © 2022 Ryan Ciehanski ]]
--[[ MIT license, see LICENSE for more details. ]]

local M = {}
local api = vim.api
local inspect = vim.inspect
local format = string.format
local utils = require("nvim-git-line.utils")

function M.go()
  -- Get github URL
  local url = M.get_github_url(false)
  -- Open it in default browser from nvim
  utils.open_url(url)
end

function M.go_line()
  -- Get github URL
  local url = M.get_github_url(true)
  -- Open it in default browser from nvim
  utils.open_url(url)
end

function M.get_github_url(line_lookup)
  -- Get current line number
  local linenr = inspect(api.nvim_win_get_cursor(0))
  -- Get buffer name of open nvim buffer
  local bufname = utils.get_buffer_name()
  -- Get git branch name
  local branch = utils.get_git_branch_name()
  -- Get repo name
  local repo = utils.get_remote_repo_name()
  -- Get remote username from remote repo URL
  local username = utils.get_remote_username()
  -- Craft Github URL
  local github_url = ""
  if line_lookup then
    github_url = format("https://github.com/%s/%s/blob/%s/%s#%d", username, repo, branch, bufname, linenr)
  else
    github_url = format("https://github.com/%s/%s/blob/%s/%s", username, repo, branch, bufname)
  end
  -- Ship it
  return github_url
end

return M
