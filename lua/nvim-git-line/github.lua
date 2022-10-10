--[[ Copyright © 2022 Ryan Ciehanski ]]
--[[ MIT license, see LICENSE for more details. ]]

-- @module "nvim-git-line.utils"
local utils = require("nvim-git-line.utils")

local M = {}

local api = vim.api
local inspect = vim.inspect
local format = string.format

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

-- @param line_lookup Boolean
-- @return String
function M.get_github_url(line_lookup)
  -- Get buffer name of open nvim buffer
  local bufname = utils.get_buffer_name()
  -- Get git branch name
  local branch = utils.get_branch_name()
  -- Get repo name
  local repo = utils.get_remote_repo_name()
  -- Get remote username from remote repo URL
  local username = utils.get_remote_username()
  -- Craft Github URL
  local github_url = ""
  if line_lookup then
    -- Get current line number
    local linenr = utils.get_line_number()
    github_url = format("https://github.com/%s/%s/blob/%s/%s#L%s", username, repo, branch, bufname, linenr)
  else
    github_url = format("https://github.com/%s/%s/blob/%s/%s", username, repo, branch, bufname)
  end
  -- Ship it
  return github_url
end

return M
