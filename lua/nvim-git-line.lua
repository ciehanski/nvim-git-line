--[[ Copyright © 2022 Ryan Ciehanski ]]
--[[ MIT license, see LICENSE for more details. ]]

local M = {}
local api = vim.api
local github = require("nvim-git-line.github")

local default = {
  provider = "github",
  action_key = "<leader>gp",
  action_key_line = "<leader>gl",
  debug = false,
}

function M.setup(user_config)
  M.config = vim.tbl_deep_extend("force", {}, default, user_config or {})

  -- Set keymappings
  api.nvim_set_keymap("n", M.config.action_key, "", {
    callback = github.go,
    desc = "Opens the current file in the GitHub repository with your default browser.",
    silent = not M.config.debug,
    noremap = false,
  })
  api.nvim_set_keymap("n", M.config.action_key_line, "", {
    callback = github.go_line,
    desc = "Opens the current file at the line under your cursor in the GitHub repository with your default browser.",
    silent = not M.config.debug,
    noremap = false,
  })
end

return M
