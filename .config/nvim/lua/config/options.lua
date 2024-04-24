-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Set mapleader and maplocalleader
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Disable LazyVim auto format
vim.g.autoformat = false

local opt = vim.opt

opt.backup = false                          -- creates a backup file
opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
opt.swapfile = false                        -- creates a swapfile
opt.undofile = true                         -- enable persistent undo
opt.undolevels=1000                         -- Maximum number of changes that can be undoneopt.opt.undoreload=10000,                        -- Maximum number lines to save for undo on a buffer reload
opt.history=1000                            -- Store a ton of history (default is 20)
opt.autowrite = false                       -- Disable auto write
opt.fileformats = {"unix", "dos"}           -- file format as 'unix' or 'dos'
-- opt.encoding = "utf-8"
-- opt.termencoding = "utf-8"
opt.fileencoding = "utf-8"                  -- the encoding written to a file
opt.fileencodings = {                        -- the encodings supported when loading a file
    "utf-8",
    "chinese",
    "ucs-bom",
    "cp936",
    "gb18030",
    "big5",
    "bgk",
    "euc-jp",
    "euc-kr",
    "latin1",
}
opt.expandtab = true                        -- convert tabs to spaces
opt.shiftwidth = 4                          -- the number of spaces inserted for each indentation
opt.tabstop = 4                             -- insert 2 spaces for a tab
opt.smartindent = true                      -- make indenting smarter again
opt.splitbelow = true                       -- force all horizontal splits to go below current window
opt.splitright = true                       -- force all vertical splits to go to the right of current window
opt.gdefault = true                         -- Set g switch as default option for re
opt.ignorecase = true                       -- ignore case in search patterns
opt.smartcase = true                        -- smart case
opt.hlsearch = true                         -- highlight all matches on previous search pattern
opt.timeoutlen = 100                        -- time to wait for a mapped sequence to complete (in milliseconds)
opt.updatetime = 300                        -- faster completion (4000ms default)
opt.showtabline = 2                         -- always show tabs
opt.pumheight = 10                          -- pop up menu height
opt.showmode = false                        -- we don't need to see things like -- INSERT -- anymore
opt.showtabline = 2                         -- always show tabs
opt.termguicolors = true                    -- set term gui colors (most terminals support this)
opt.cursorline = true                       -- highlight the current line
opt.number = true                           -- set numbered lines
opt.relativenumber = true                   -- set relative numbered lines
opt.numberwidth = 4                         -- set number column width to 2 {default 4}
opt.signcolumn = "yes"                      -- always show the sign column otherwise it would shift the text each time
opt.wrap = false                            -- display lines as one long line
opt.scrolloff = 3                           -- minimum lines to keep above and below cursor
opt.sidescrolloff = 8                       -- Columns of context
opt.cmdheight = 1                           -- more space in the neovim command line for displaying messages
opt.autochdir = true                        -- auto change current working directory

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work
vim.cmd [[let g:netrw_bufsettings = 'noma nomod nu nowrap ro nobl']]

-- if vim.fn.has('wsl') == 1 then
--     vim.g.clipboard = {
--         name = 'WslClipboard',
--         copy = {
--             ['+'] = 'clip.exe',
--             ['*'] = 'clip.exe',
--         },
--         paste = {
--             ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
--             ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
--         },
--         cache_enabled = 0,
--     }
-- end

if vim.fn.has('wsl') == 1 then
  vim.g.clipboard = {
          name = "win32yank-wsl",
          copy = {
              ["+"] = "win32yank.exe -i --crlf",
              ["*"] = "win32yank.exe -i --crlf",
          },
          paste = {
              ["+"] = "win32yank.exe -o --lf",
              ["*"] = "win32yank.exe -o --lf",
          },
          cache_enabled = true,
      }
end
