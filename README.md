# nvim-git-line

A Vim Plugin written in Lua to quickly open the buffer's current line in GitHub using your default browser.

## Installation

#### Lua:
```lua
use { 'ciehanski/nvim-git-line' }
```

#### Vimscript:
```vim
Plug 'ciehanski/nvim-git-line'
```

## Usage

#### Lua:
```lua
require("nvim-git-line").setup{}
```

#### Vimscript:
```vim
lua << EOF
require("nvim-git-line").setup{}
EOF
```

#### Custom keymappings:
```lua
require('nvim-git-line').setup{
  action_key = "<leader>gg",
  action_key_line = "<leader>gl",
}
```

#### Custom provider (GitHub, GitLab):
```lua
require('nvim-git-line').setup{
  provider = "gitlab", -- github, gitlab
}
```
