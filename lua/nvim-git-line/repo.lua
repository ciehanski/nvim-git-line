--[[ Copyright © 2022 Ryan Ciehanski <ryan@ciehanski.com> ]]
--[[ MIT license, see LICENSE for more details. ]]

-- @module "nvim-git-line.utils"
local utils = require("nvim-git-line.utils")

local M = {}

local format = string.format

function M.go()
  -- Get github URL
  local url = M.get_repo_url(false)
  -- Open it in default browser from nvim
  utils.open_url(url)
end

function M.go_line()
  -- Get github URL
  local url = M.get_repo_url(true)
  -- Open it in default browser from nvim
  utils.open_url(url)
end

-- @param line_lookup boolean
-- @return string
function M.get_repo_url(line_lookup)
  -- Get repo name
  local repo = utils.get_remote_repo_name()
  -- Get remote username from remote repo URL
  local username = utils.get_remote_username()
  -- Get git branch name
  local branch = utils.get_branch_name()
  -- Get buffer name of open nvim buffer
  local bufname = utils.get_buffer_name(repo)
  -- Format repo URL
  local repo_url = ""
  if line_lookup then
    -- Get current line number
    local linenr = utils.get_line_number()
    -- if string.lower(M.config.provider) == "github" then
      repo_url = format("https://github.com/%s/%s/blob/%s/%s#L%s", username, repo, branch, bufname, linenr)
    -- else
    --   repo_url = format("https://gitlab.com/%s/%s/-/blob/%s/%s#L%s", username, repo, branch, bufname, linenr)
    -- end
  else
    -- if string.lower(M.config.provider) == "github" then
      repo_url = format("https://github.com/%s/%s/blob/%s/%s", username, repo, branch, bufname)
    -- else
    --   repo_url = format("https://gitlab.com/%s/%s/-/blob/%s/%s", username, repo, branch, bufname)
    -- end
  end
  -- Ship it
  return repo_url
end

return M
