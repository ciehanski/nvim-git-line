--[[ Copyright © 2022 Ryan Ciehanski <ryan@ciehanski.com> ]]
--[[ MIT license, see LICENSE for more details. ]]

-- @module "nvim-git-line.github"
local repo = require("nvim-git-line.repo")

local M = {}

local api = vim.api

local default_config = {
  provider = "github",
  action_key = "<leader>gp",
  action_key_line = "<leader>gl",
  debug = false,
}

function M.setup(user_config)
  -- Export Module
  _G.NvimGitLine = M

  -- Get Config
  M.config = vim.tbl_deep_extend("force", default_config, vim.b.nvim_git_line_config or {}, user_config or {})

  -- Set keymappings
  -- Open buffer in remote repo
  api.nvim_set_keymap("n", M.config.action_key, "", {
    callback = repo.go,
    desc = "Opens the current file in the GitHub repository with your default browser.",
    silent = not M.config.debug,
    noremap = false,
  })
  -- Open buffer + current line number in remote repo
  api.nvim_set_keymap("n", M.config.action_key_line, "", {
    callback = repo.go_line,
    desc = "Opens the current file at the line under your cursor in the GitHub repository with your default browser.",
    silent = not M.config.debug,
    noremap = false,
  })
end

return M
